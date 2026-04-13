import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';

@Schema({ timestamps: true })
export class CompanyValuation extends Document {
  @Prop({ required: true }) valuationAmount: number;
  @Prop({ default: 'AED' }) currency: string;
  @Prop({ required: true }) totalAum: number;
  @Prop({ required: true }) activeClients: number;
  @Prop({ required: true }) growthPercent: number;
  @Prop({ required: true }) period: string;
  @Prop({ required: true }) valuationDate: Date;
  @Prop() reportUrl?: string;
  @Prop() notes?: string;
  @Prop({ type: Types.ObjectId, ref: 'User', required: true }) createdBy: Types.ObjectId;
}

export const CompanyValuationSchema = SchemaFactory.createForClass(CompanyValuation);
CompanyValuationSchema.index({ valuationDate: -1 });
