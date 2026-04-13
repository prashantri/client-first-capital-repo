import mongoose, { Schema, Document } from 'mongoose';

export interface IShareholding extends Document {
  investorId: mongoose.Types.ObjectId;
  sharesHeld: number;
  shareClass: string;
  ownershipPercent: number;
  purchasePrice: number;
  currentValuePerShare: number;
  totalValue: number;
  currency: string;
  purchaseDate: Date;
  certificateUrl?: string;
  createdAt: Date;
  updatedAt: Date;
}

const shareholdingSchema = new Schema<IShareholding>(
  {
    investorId: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    sharesHeld: { type: Number, required: true },
    shareClass: { type: String, required: true, default: 'Class A' },
    ownershipPercent: { type: Number, required: true },
    purchasePrice: { type: Number, required: true },
    currentValuePerShare: { type: Number, required: true },
    totalValue: { type: Number, required: true },
    currency: { type: String, default: 'AED' },
    purchaseDate: { type: Date, required: true },
    certificateUrl: String,
  },
  { timestamps: true }
);

shareholdingSchema.index({ investorId: 1 });

export const Shareholding = mongoose.model<IShareholding>('Shareholding', shareholdingSchema);
