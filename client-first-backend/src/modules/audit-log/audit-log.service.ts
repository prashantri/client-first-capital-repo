import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { AuditLog } from '../../schemas/audit-log.schema';

@Injectable()
export class AuditLogService {
  constructor(@InjectModel(AuditLog.name) private model: Model<AuditLog>) {}

  async log(data: {
    adminId: string;
    adminName: string;
    adminEmail: string;
    action: 'approved' | 'rejected';
    kycApplicationId: string;
    applicantName: string;
    applicantEmail: string;
    notes?: string;
    rejectionReason?: string;
  }) {
    return this.model.create(data);
  }

  async findAll(query: { page?: number; limit?: number; action?: string }) {
    const filter: any = {};
    if (query.action) filter.action = query.action;
    const page = Number(query.page) || 1;
    const limit = Number(query.limit) || 20;
    const [data, total] = await Promise.all([
      this.model.find(filter).sort({ createdAt: -1 }).skip((page - 1) * limit).limit(limit),
      this.model.countDocuments(filter),
    ]);
    return { data, total, page, limit, totalPages: Math.ceil(total / limit) };
  }
}
