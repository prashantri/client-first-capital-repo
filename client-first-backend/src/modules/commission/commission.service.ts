import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model, Types } from 'mongoose';
import { Commission } from '../../schemas/commission.schema';

@Injectable()
export class CommissionService {
  constructor(@InjectModel(Commission.name) private model: Model<Commission>) {}

  async findByIntroducer(introducerId: string, query: { status?: string; page?: number; limit?: number }) {
    const filter: any = { introducerId };
    if (query.status) filter.status = query.status;
    const page = query.page || 1;
    const limit = query.limit || 20;
    const [data, total] = await Promise.all([
      this.model.find(filter).skip((page - 1) * limit).limit(limit).sort({ createdAt: -1 }),
      this.model.countDocuments(filter),
    ]);
    return { data, total, page, limit, totalPages: Math.ceil(total / limit) };
  }

  async getIntroducerSummary(introducerId: string) {
    const result = await this.model.aggregate([
      { $match: { introducerId: new Types.ObjectId(introducerId) } },
      { $group: { _id: '$status', total: { $sum: '$amount' }, count: { $sum: 1 } } },
    ]);
    return result;
  }

  async findAll(query: { status?: string; page?: number; limit?: number }) {
    const filter: any = {};
    if (query.status) filter.status = query.status;
    const page = query.page || 1;
    const limit = query.limit || 20;
    const [data, total] = await Promise.all([
      this.model.find(filter).skip((page - 1) * limit).limit(limit).sort({ createdAt: -1 }).populate('introducerId', 'fullName'),
      this.model.countDocuments(filter),
    ]);
    return { data, total, page, limit, totalPages: Math.ceil(total / limit) };
  }

  async create(data: Partial<Commission>) { return this.model.create(data); }
  async update(id: string, data: Partial<Commission>) { return this.model.findByIdAndUpdate(id, data, { new: true }); }
}
