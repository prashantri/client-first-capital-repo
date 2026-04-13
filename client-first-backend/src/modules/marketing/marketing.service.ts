import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { MarketingAsset } from '../../schemas/marketing-asset.schema';

@Injectable()
export class MarketingService {
  constructor(@InjectModel(MarketingAsset.name) private model: Model<MarketingAsset>) {}

  async findAll(query: { type?: string; category?: string; page?: number; limit?: number }) {
    const filter: any = { isActive: true };
    if (query.type) filter.type = query.type;
    if (query.category) filter.category = query.category;
    const page = query.page || 1;
    const limit = query.limit || 20;
    const [data, total] = await Promise.all([
      this.model.find(filter).skip((page - 1) * limit).limit(limit).sort({ createdAt: -1 }),
      this.model.countDocuments(filter),
    ]);
    return { data, total, page, limit, totalPages: Math.ceil(total / limit) };
  }

  async findById(id: string) { return this.model.findById(id); }
  async create(data: Partial<MarketingAsset>) { return this.model.create(data); }
  async update(id: string, data: Partial<MarketingAsset>) { return this.model.findByIdAndUpdate(id, data, { new: true }); }
  async incrementDownload(id: string) { return this.model.findByIdAndUpdate(id, { $inc: { downloadCount: 1 } }, { new: true }); }
}
