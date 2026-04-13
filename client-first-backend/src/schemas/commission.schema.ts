import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';

@Schema({ timestamps: true })
export class Commission extends Document {
  @Prop({ type: Types.ObjectId, ref: 'User', required: true })
  introducerId: Types.ObjectId;

  @Prop({ type: Types.ObjectId, ref: 'Referral', required: true })
  referralId: Types.ObjectId;

  @Prop({ required: true, enum: ['referral_bonus', 'aum_percentage', 'performance_bonus'] })
  type: string;

  @Prop({ required: true })
  amount: number;

  @Prop({ default: 'AED' })
  currency: string;

  @Prop({ default: 'pending', enum: ['pending', 'approved', 'paid', 'cancelled'] })
  status: string;

  @Prop()
  percentage?: number;

  @Prop()
  aumGenerated?: number;

  @Prop()
  paymentDate?: Date;

  @Prop()
  paymentReference?: string;

  @Prop({ type: Object })
  period?: { startDate: Date; endDate: Date };
}

export const CommissionSchema = SchemaFactory.createForClass(Commission);
CommissionSchema.index({ introducerId: 1, status: 1 });
