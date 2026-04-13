import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Appointment } from '../../schemas/appointment.schema';

@Injectable()
export class AppointmentService {
  constructor(@InjectModel(Appointment.name) private model: Model<Appointment>) {}

  async findByCustomer(customerId: string) {
    return this.model.find({ customerId }).sort({ scheduledAt: -1 }).populate('advisorId', 'fullName email');
  }

  async findByAdvisor(advisorId: string) {
    return this.model.find({ advisorId }).sort({ scheduledAt: -1 }).populate('customerId', 'fullName email');
  }

  async create(data: Partial<Appointment>) { return this.model.create(data); }
  async update(id: string, data: Partial<Appointment>) { return this.model.findByIdAndUpdate(id, data, { new: true }); }
  async findById(id: string) { return this.model.findById(id).populate('customerId', 'fullName email').populate('advisorId', 'fullName email'); }

  async findAll(query: { status?: string; page?: number; limit?: number }) {
    const filter: any = {};
    if (query.status) filter.status = query.status;
    const page = query.page || 1;
    const limit = query.limit || 20;
    const [data, total] = await Promise.all([
      this.model.find(filter).skip((page - 1) * limit).limit(limit).sort({ scheduledAt: -1 }).populate('customerId', 'fullName').populate('advisorId', 'fullName'),
      this.model.countDocuments(filter),
    ]);
    return { data, total, page, limit, totalPages: Math.ceil(total / limit) };
  }
}
