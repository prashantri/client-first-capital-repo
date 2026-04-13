import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';

@Schema({ timestamps: true })
export class Goal extends Document {
  @Prop({ type: Types.ObjectId, ref: 'User', required: true })
  customerId: Types.ObjectId;

  @Prop({ required: true, trim: true })
  name: string;

  @Prop({ required: true, enum: ['retirement', 'education', 'home_purchase', 'wealth_building', 'emergency_fund', 'custom'] })
  type: string;

  @Prop({ required: true }) targetAmount: number;
  @Prop({ default: 0 }) currentAmount: number;
  @Prop({ default: 'AED' }) currency: string;
  @Prop({ required: true }) targetDate: Date;
  @Prop() monthlyContribution?: number;

  @Prop({ default: 'active', enum: ['active', 'paused', 'completed', 'cancelled'] })
  status: string;

  @Prop({ default: 0, min: 0, max: 100 }) progressPercent: number;
  @Prop() notes?: string;
}

export const GoalSchema = SchemaFactory.createForClass(Goal);
GoalSchema.index({ customerId: 1, status: 1 });
