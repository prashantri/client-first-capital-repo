import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Shareholding } from '../../schemas/shareholding.schema';

@Injectable()
export class ShareholdingService {
  constructor(@InjectModel(Shareholding.name) private model: Model<Shareholding>) {}

  async findByInvestor(investorId: string) { return this.model.find({ investorId }); }
  async findAll() { return this.model.find().populate('investorId', 'fullName email'); }
  async create(data: Partial<Shareholding>) { return this.model.create(data); }
  async update(id: string, data: Partial<Shareholding>) { return this.model.findByIdAndUpdate(id, data, { new: true }); }
}
