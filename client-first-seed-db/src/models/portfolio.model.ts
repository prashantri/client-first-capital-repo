import mongoose, { Schema, Document } from 'mongoose';

export enum RiskLevel {
  CONSERVATIVE = 'conservative',
  MODERATE = 'moderate',
  AGGRESSIVE = 'aggressive',
}

export interface IHolding {
  symbol: string;
  name: string;
  assetClass: string;
  quantity: number;
  avgBuyPrice: number;
  currentPrice: number;
  marketValue: number;
  gainLoss: number;
  gainLossPercent: number;
  currency: string;
}

export interface IPortfolio extends Document {
  customerId: mongoose.Types.ObjectId;
  advisorId: mongoose.Types.ObjectId;
  portfolioName: string;
  totalValue: number;
  investedAmount: number;
  currency: string;
  riskLevel: RiskLevel;
  // Allocation breakdown
  allocation: {
    equities: number;
    bonds: number;
    realEstate: number;
    cash: number;
    alternatives?: number;
  };
  holdings: IHolding[];
  // Performance
  ytdReturn: number;
  absoluteGain: number;
  disciplineScore: number;
  // Metadata
  inceptionDate: Date;
  lastRebalancedAt?: Date;
  isActive: boolean;
  createdAt: Date;
  updatedAt: Date;
}

const holdingSchema = new Schema<IHolding>(
  {
    symbol: { type: String, required: true },
    name: { type: String, required: true },
    assetClass: { type: String, required: true },
    quantity: { type: Number, required: true },
    avgBuyPrice: { type: Number, required: true },
    currentPrice: { type: Number, required: true },
    marketValue: { type: Number, required: true },
    gainLoss: { type: Number, required: true },
    gainLossPercent: { type: Number, required: true },
    currency: { type: String, default: 'AED' },
  },
  { _id: false }
);

const portfolioSchema = new Schema<IPortfolio>(
  {
    customerId: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    advisorId: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    portfolioName: { type: String, required: true, trim: true },
    totalValue: { type: Number, required: true },
    investedAmount: { type: Number, required: true },
    currency: { type: String, default: 'AED' },
    riskLevel: { type: String, enum: Object.values(RiskLevel), required: true },
    allocation: {
      equities: { type: Number, default: 0 },
      bonds: { type: Number, default: 0 },
      realEstate: { type: Number, default: 0 },
      cash: { type: Number, default: 0 },
      alternatives: { type: Number, default: 0 },
    },
    holdings: [holdingSchema],
    ytdReturn: { type: Number, default: 0 },
    absoluteGain: { type: Number, default: 0 },
    disciplineScore: { type: Number, default: 0, min: 0, max: 100 },
    inceptionDate: { type: Date, required: true },
    lastRebalancedAt: Date,
    isActive: { type: Boolean, default: true },
  },
  { timestamps: true }
);

portfolioSchema.index({ customerId: 1 });
portfolioSchema.index({ advisorId: 1 });

export const Portfolio = mongoose.model<IPortfolio>('Portfolio', portfolioSchema);
