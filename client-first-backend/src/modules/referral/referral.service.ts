import { Injectable, ConflictException, Logger } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Referral } from '../../schemas/referral.schema';
import { HubspotService } from '../hubspot/hubspot.service';

@Injectable()
export class ReferralService {
  private readonly logger = new Logger(ReferralService.name);

  constructor(
    @InjectModel(Referral.name) private referralModel: Model<Referral>,
    private hubspotService: HubspotService,
  ) {}

  async create(
    data: Partial<Referral>,
    introducer: { fullName: string; email: string },
  ) {
    const email = (data.referralEmail ?? '').toLowerCase().trim();
    const existing = await this.referralModel.findOne({ referralEmail: email });
    if (existing) {
      throw new ConflictException('A referral with this email already exists');
    }

    const referral = await this.referralModel.create({ ...data, referralEmail: email });

    // Fire-and-forget: push to HubSpot in background
    this.hubspotService
      .pushReferral({
        referralName: data.referralName ?? '',
        referralEmail: email,
        referralPhone: data.referralPhone ?? '',
        serviceType: data.serviceType,
        notes: data.notes,
        introducerName: introducer.fullName,
        introducerEmail: introducer.email,
      })
      .then(({ hubspotContactId, hubspotDealId }) => {
        this.referralModel
          .findByIdAndUpdate(referral._id, { hubspotContactId, hubspotDealId })
          .exec();
        this.logger.log(
          `HubSpot: contact=${hubspotContactId} deal=${hubspotDealId} for referral ${referral._id}`,
        );
      })
      .catch((err: Error) =>
        this.logger.error(`HubSpot push failed for referral ${referral._id}: ${err.message}`),
      );

    return referral;
  }

  async findByIntroducer(introducerId: string, query: { status?: string; page?: number; limit?: number }) {
    const filter: any = { introducerId };
    if (query.status) filter.status = query.status;
    const page = query.page || 1;
    const limit = query.limit || 20;
    const [data, total] = await Promise.all([
      this.referralModel.find(filter).skip((page - 1) * limit).limit(limit).sort({ createdAt: -1 }).populate('assignedAdvisorId', 'fullName email'),
      this.referralModel.countDocuments(filter),
    ]);
    return { data, total, page, limit, totalPages: Math.ceil(total / limit) };
  }

  async findByAdvisor(advisorId: string) {
    return this.referralModel.find({ assignedAdvisorId: advisorId }).sort({ createdAt: -1 }).populate('introducerId', 'fullName email');
  }

  async findById(id: string) {
    return this.referralModel.findById(id).populate('introducerId', 'fullName email').populate('assignedAdvisorId', 'fullName email');
  }

  async update(id: string, data: Partial<Referral>) {
    return this.referralModel.findByIdAndUpdate(id, data, { new: true });
  }

  async getIntroducerStats(introducerId: string) {
    const stats = await this.referralModel.aggregate([
      { $match: { introducerId: new (require('mongoose').Types.ObjectId)(introducerId) } },
      {
        $group: {
          _id: '$status',
          count: { $sum: 1 },
          totalEstimated: { $sum: '$estimatedInvestment' },
        },
      },
    ]);
    return stats;
  }

  async findAll(query: {
    status?: string;
    search?: string;
    introducerId?: string;
    dateFrom?: string;
    dateTo?: string;
    page?: number;
    limit?: number;
  }) {
    const filter: any = {};
    if (query.status) filter.status = query.status;
    if (query.introducerId) filter.introducerId = query.introducerId;
    if (query.search) {
      filter.$or = [
        { referralName: { $regex: query.search, $options: 'i' } },
        { referralEmail: { $regex: query.search, $options: 'i' } },
      ];
    }
    if (query.dateFrom || query.dateTo) {
      filter.createdAt = {};
      if (query.dateFrom) filter.createdAt.$gte = new Date(query.dateFrom);
      if (query.dateTo) {
        const to = new Date(query.dateTo);
        to.setHours(23, 59, 59, 999);
        filter.createdAt.$lte = to;
      }
    }
    const page = query.page || 1;
    const limit = query.limit || 20;
    const [data, total] = await Promise.all([
      this.referralModel
        .find(filter)
        .skip((page - 1) * limit)
        .limit(limit)
        .sort({ createdAt: -1 })
        .populate('introducerId', 'fullName email')
        .populate('assignedAdvisorId', 'fullName'),
      this.referralModel.countDocuments(filter),
    ]);
    return { data, total, page, limit, totalPages: Math.ceil(total / limit) };
  }
}
