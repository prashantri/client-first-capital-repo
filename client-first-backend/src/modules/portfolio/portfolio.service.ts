import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Portfolio } from '../../schemas/portfolio.schema';

@Injectable()
export class PortfolioService {
  constructor(@InjectModel(Portfolio.name) private model: Model<Portfolio>) {}

  async findByCustomer(customerId: string) {
    return this.model.find({ customerId, isActive: true });
  }

  async findByAdvisor(advisorId: string) {
    return this.model.find({ advisorId, isActive: true }).populate('customerId', 'fullName email');
  }

  async findById(id: string) {
    return this.model.findById(id).populate('customerId', 'fullName email').populate('advisorId', 'fullName email');
  }

  async create(data: Partial<Portfolio>) { return this.model.create(data); }
  async update(id: string, data: Partial<Portfolio>) { return this.model.findByIdAndUpdate(id, data, { new: true }); }

  async getAdvisorStats(advisorId: string) {
    return this.model.aggregate([
      { $match: { advisorId: new (require('mongoose').Types.ObjectId)(advisorId), isActive: true } },
      { $group: { _id: null, totalAum: { $sum: '$totalValue' }, clientCount: { $addToSet: '$customerId' }, avgReturn: { $avg: '$ytdReturn' } } },
      { $project: { totalAum: 1, clientCount: { $size: '$clientCount' }, avgReturn: 1 } },
    ]);
  }

  async findAll(query: { page?: number; limit?: number }) {
    const page = query.page || 1;
    const limit = query.limit || 20;
    const [data, total] = await Promise.all([
      this.model.find().skip((page - 1) * limit).limit(limit).populate('customerId', 'fullName').populate('advisorId', 'fullName'),
      this.model.countDocuments(),
    ]);
    return { data, total, page, limit, totalPages: Math.ceil(total / limit) };
  }
}
