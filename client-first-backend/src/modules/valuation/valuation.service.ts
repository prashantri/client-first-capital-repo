import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { CompanyValuation } from '../../schemas/company-valuation.schema';

@Injectable()
export class ValuationService {
  constructor(@InjectModel(CompanyValuation.name) private model: Model<CompanyValuation>) {}

  async findAll() { return this.model.find().sort({ valuationDate: -1 }); }
  async findLatest() { return this.model.findOne().sort({ valuationDate: -1 }); }
  async create(data: Partial<CompanyValuation>) { return this.model.create(data); }
  async update(id: string, data: Partial<CompanyValuation>) { return this.model.findByIdAndUpdate(id, data, { new: true }); }
}
