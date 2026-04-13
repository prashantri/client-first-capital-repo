import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';

@Schema({ _id: false })
export class Holding {
  @Prop({ required: true }) symbol: string;
  @Prop({ required: true }) name: string;
  @Prop({ required: true }) assetClass: string;
  @Prop({ required: true }) quantity: number;
  @Prop({ required: true }) avgBuyPrice: number;
  @Prop({ required: true }) currentPrice: number;
  @Prop({ required: true }) marketValue: number;
  @Prop({ required: true }) gainLoss: number;
  @Prop({ required: true }) gainLossPercent: number;
  @Prop({ default: 'AED' }) currency: string;
}

@Schema({ timestamps: true })
export class Portfolio extends Document {
  @Prop({ type: Types.ObjectId, ref: 'User', required: true })
  customerId: Types.ObjectId;

  @Prop({ type: Types.ObjectId, ref: 'User', required: true })
  advisorId: Types.ObjectId;

  @Prop({ required: true, trim: true })
  portfolioName: string;

  @Prop({ required: true })
  totalValue: number;

  @Prop({ required: true })
  investedAmount: number;

  @Prop({ default: 'AED' })
  currency: string;

  @Prop({ required: true, enum: ['conservative', 'moderate', 'aggressive'] })
  riskLevel: string;

  @Prop({ type: Object })
  allocation: { equities: number; bonds: number; realEstate: number; cash: number; alternatives?: number };

  @Prop({ type: [Holding] })
  holdings: Holding[];

  @Prop({ default: 0 }) ytdReturn: number;
  @Prop({ default: 0 }) absoluteGain: number;
  @Prop({ default: 0, min: 0, max: 100 }) disciplineScore: number;
  @Prop({ required: true }) inceptionDate: Date;
  @Prop() lastRebalancedAt?: Date;
  @Prop({ default: true }) isActive: boolean;
}

export const PortfolioSchema = SchemaFactory.createForClass(Portfolio);
PortfolioSchema.index({ customerId: 1 });
PortfolioSchema.index({ advisorId: 1 });
