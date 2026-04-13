import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { EducationContent } from '../../schemas/education-content.schema';

@Injectable()
export class EducationService {
  constructor(@InjectModel(EducationContent.name) private model: Model<EducationContent>) {}

  async findPublished(query: { category?: string; page?: number; limit?: number }) {
    const filter: any = { isPublished: true };
    if (query.category) filter.category = query.category;
    const page = query.page || 1;
    const limit = query.limit || 20;
    const [data, total] = await Promise.all([
      this.model.find(filter).skip((page - 1) * limit).limit(limit).sort({ publishedAt: -1 }),
      this.model.countDocuments(filter),
    ]);
    return { data, total, page, limit, totalPages: Math.ceil(total / limit) };
  }

  async findById(id: string) {
    await this.model.findByIdAndUpdate(id, { $inc: { viewCount: 1 } });
    return this.model.findById(id);
  }

  async findAll(query: { page?: number; limit?: number }) {
    const page = query.page || 1;
    const limit = query.limit || 20;
    const [data, total] = await Promise.all([
      this.model.find().skip((page - 1) * limit).limit(limit).sort({ createdAt: -1 }),
      this.model.countDocuments(),
    ]);
    return { data, total, page, limit, totalPages: Math.ceil(total / limit) };
  }

  async create(data: Partial<EducationContent>) { return this.model.create(data); }
  async update(id: string, data: Partial<EducationContent>) { return this.model.findByIdAndUpdate(id, data, { new: true }); }
}
