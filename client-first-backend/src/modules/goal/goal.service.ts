import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Goal } from '../../schemas/goal.schema';

@Injectable()
export class GoalService {
  constructor(@InjectModel(Goal.name) private model: Model<Goal>) {}

  async findByCustomer(customerId: string) {
    return this.model.find({ customerId }).sort({ createdAt: -1 });
  }

  async create(data: Partial<Goal>) { return this.model.create(data); }
  async update(id: string, data: Partial<Goal>) { return this.model.findByIdAndUpdate(id, data, { new: true }); }
  async findById(id: string) { return this.model.findById(id); }
  async delete(id: string) { return this.model.findByIdAndDelete(id); }
}
