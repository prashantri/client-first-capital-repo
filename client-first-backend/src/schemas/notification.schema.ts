import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';

@Schema({ timestamps: true })
export class Notification extends Document {
  @Prop({ type: Types.ObjectId, ref: 'User', required: true }) userId: Types.ObjectId;
  @Prop({ required: true, enum: ['kyc_update', 'referral_update', 'commission_paid', 'appointment_reminder', 'market_alert', 'portfolio_update', 'education_new', 'compliance_due', 'system'] })
  type: string;
  @Prop({ required: true }) title: string;
  @Prop({ required: true }) message: string;
  @Prop({ type: Object }) data?: Record<string, unknown>;
  @Prop({ default: false }) isRead: boolean;
  @Prop() readAt?: Date;
}

export const NotificationSchema = SchemaFactory.createForClass(Notification);
NotificationSchema.index({ userId: 1, isRead: 1, createdAt: -1 });
