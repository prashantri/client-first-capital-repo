import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Referral } from '../../schemas/referral.schema';

@Injectable()
export class ReferralService {
  constructor(@InjectModel(Referral.name) private referralModel: Model<Referral>) {}

  async create(data: Partial<Referral>) {
    return this.referralModel.create(data);
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

  async findAll(query: { status?: string; page?: number; limit?: number }) {
    const filter: any = {};
    if (query.status) filter.status = query.status;
    const page = query.page || 1;
    const limit = query.limit || 20;
    const [data, total] = await Promise.all([
      this.referralModel.find(filter).skip((page - 1) * limit).limit(limit).sort({ createdAt: -1 }).populate('introducerId', 'fullName').populate('assignedAdvisorId', 'fullName'),
      this.referralModel.countDocuments(filter),
    ]);
    return { data, total, page, limit, totalPages: Math.ceil(total / limit) };
  }
}
