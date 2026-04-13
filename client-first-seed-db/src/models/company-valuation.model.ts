import mongoose, { Schema, Document } from 'mongoose';

export interface ICompanyValuation extends Document {
  valuationAmount: number;
  currency: string;
  totalAum: number;
  activeClients: number;
  growthPercent: number;
  period: string; // e.g., 'Q4 2025'
  valuationDate: Date;
  reportUrl?: string;
  notes?: string;
  createdBy: mongoose.Types.ObjectId;
  createdAt: Date;
  updatedAt: Date;
}

const companyValuationSchema = new Schema<ICompanyValuation>(
  {
    valuationAmount: { type: Number, required: true },
    currency: { type: String, default: 'AED' },
    totalAum: { type: Number, required: true },
    activeClients: { type: Number, required: true },
    growthPercent: { type: Number, required: true },
    period: { type: String, required: true },
    valuationDate: { type: Date, required: true },
    reportUrl: String,
    notes: String,
    createdBy: { type: Schema.Types.ObjectId, ref: 'User', required: true },
  },
  { timestamps: true }
);

companyValuationSchema.index({ valuationDate: -1 });

export const CompanyValuation = mongoose.model<ICompanyValuation>('CompanyValuation', companyValuationSchema);
