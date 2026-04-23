import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';

@Schema({ timestamps: true })
export class AuditLog extends Document {
  @Prop({ type: Types.ObjectId, ref: 'User', required: true })
  adminId: Types.ObjectId;

  @Prop({ required: true }) adminName: string;
  @Prop({ required: true }) adminEmail: string;

  @Prop({ required: true, enum: ['approved', 'rejected'] })
  action: string;

  @Prop({ type: Types.ObjectId, ref: 'KycApplication', required: true })
  kycApplicationId: Types.ObjectId;

  @Prop({ required: true }) applicantName: string;
  @Prop({ required: true }) applicantEmail: string;

  @Prop() notes?: string;
  @Prop() rejectionReason?: string;
}

export const AuditLogSchema = SchemaFactory.createForClass(AuditLog);
AuditLogSchema.index({ adminId: 1 });
AuditLogSchema.index({ action: 1 });
AuditLogSchema.index({ createdAt: -1 });
