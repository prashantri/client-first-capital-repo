import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { ComplianceChecklist } from '../../schemas/compliance-checklist.schema';

@Injectable()
export class ComplianceService {
  constructor(@InjectModel(ComplianceChecklist.name) private model: Model<ComplianceChecklist>) {}

  async findByAdvisor(advisorId: string) {
    return this.model.find({ advisorId }).sort({ dueDate: 1 });
  }

  async findAll(query: { status?: string; page?: number; limit?: number }) {
    const filter: any = {};
    if (query.status) filter.status = query.status;
    const page = query.page || 1;
    const limit = query.limit || 20;
    const [data, total] = await Promise.all([
      this.model.find(filter).skip((page - 1) * limit).limit(limit).sort({ dueDate: 1 }),
      this.model.countDocuments(filter),
    ]);
    return { data, total, page, limit, totalPages: Math.ceil(total / limit) };
  }

  async create(data: Partial<ComplianceChecklist>) { return this.model.create(data); }

  async update(id: string, data: Partial<ComplianceChecklist>) {
    return this.model.findByIdAndUpdate(id, data, { new: true });
  }

  async toggleComplete(id: string) {
    const item = await this.model.findById(id);
    if (!item) return null;
    item.isCompleted = !item.isCompleted;
    item.completedAt = item.isCompleted ? new Date() : undefined;
    return item.save();
  }
}
