import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';

@Schema({ timestamps: true })
export class Referral extends Document {
  @Prop({ type: Types.ObjectId, ref: 'User', required: true })
  introducerId: Types.ObjectId;

  @Prop({ required: true, trim: true })
  referralName: string;

  @Prop({ required: true, lowercase: true, trim: true })
  referralEmail: string;

  @Prop({ required: true, trim: true })
  referralPhone: string;

  @Prop({ default: 'new', enum: ['new', 'contacted', 'meeting_scheduled', 'kyc_pending', 'kyc_submitted', 'converted', 'lost'] })
  status: string;

  @Prop()
  notes?: string;

  @Prop()
  estimatedInvestment?: number;

  @Prop({ default: 'AED' })
  currency: string;

  @Prop({ type: Types.ObjectId, ref: 'User' })
  assignedAdvisorId?: Types.ObjectId;

  @Prop({ type: Types.ObjectId, ref: 'User' })
  convertedCustomerId?: Types.ObjectId;

  @Prop()
  source?: string;

  @Prop([String])
  tags?: string[];

  @Prop()
  followUpDate?: Date;

  @Prop()
  convertedAt?: Date;
}

export const ReferralSchema = SchemaFactory.createForClass(Referral);
ReferralSchema.index({ introducerId: 1, status: 1 });
ReferralSchema.index({ assignedAdvisorId: 1 });
ReferralSchema.index({ status: 1 });
