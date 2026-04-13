import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { KycApplication } from '../../schemas/kyc-application.schema';
import { User } from '../../schemas/user.schema';

@Injectable()
export class KycService {
  constructor(
    @InjectModel(KycApplication.name) private model: Model<KycApplication>,
    @InjectModel(User.name) private userModel: Model<User>,
  ) {}

  async findByUser(userId: string) { return this.model.findOne({ userId }).sort({ createdAt: -1 }); }

  async create(data: Partial<KycApplication>) {
    const app = await this.model.create(data);
    await this.userModel.findByIdAndUpdate(data.userId, { kycStatus: 'in_progress' });
    return app;
  }

  async submit(id: string) {
    const app = await this.model.findByIdAndUpdate(id, { status: 'submitted', submittedAt: new Date() }, { new: true });
    if (!app) throw new NotFoundException('KYC application not found');
    await this.userModel.findByIdAndUpdate(app.userId, { kycStatus: 'submitted' });
    return app;
  }

  async review(id: string, reviewData: { status: 'approved' | 'rejected'; reviewedBy: string; reviewNotes?: string; rejectionReason?: string }) {
    const update: any = { status: reviewData.status, reviewedBy: reviewData.reviewedBy, reviewedAt: new Date(), reviewNotes: reviewData.reviewNotes };
    if (reviewData.status === 'approved') update.approvedAt = new Date();
    if (reviewData.status === 'rejected') update.rejectionReason = reviewData.rejectionReason;

    const app = await this.model.findByIdAndUpdate(id, update, { new: true });
    if (!app) throw new NotFoundException('KYC application not found');
    await this.userModel.findByIdAndUpdate(app.userId, {
      kycStatus: reviewData.status,
      ...(reviewData.status === 'approved' ? { status: 'active' } : {}),
    });
    return app;
  }

  async findAll(query: { status?: string; page?: number; limit?: number }) {
    const filter: any = {};
    if (query.status) filter.status = query.status;
    const page = query.page || 1;
    const limit = query.limit || 20;
    const [data, total] = await Promise.all([
      this.model.find(filter).skip((page - 1) * limit).limit(limit).sort({ createdAt: -1 }).populate('userId', 'fullName email role'),
      this.model.countDocuments(filter),
    ]);
    return { data, total, page, limit, totalPages: Math.ceil(total / limit) };
  }

  async findById(id: string) { return this.model.findById(id).populate('userId', 'fullName email role'); }
  async update(id: string, data: Partial<KycApplication>) { return this.model.findByIdAndUpdate(id, data, { new: true }); }
}
