import mongoose, { Schema, Document } from 'mongoose';

export enum NotificationType {
  KYC_UPDATE = 'kyc_update',
  REFERRAL_UPDATE = 'referral_update',
  COMMISSION_PAID = 'commission_paid',
  APPOINTMENT_REMINDER = 'appointment_reminder',
  MARKET_ALERT = 'market_alert',
  PORTFOLIO_UPDATE = 'portfolio_update',
  EDUCATION_NEW = 'education_new',
  COMPLIANCE_DUE = 'compliance_due',
  SYSTEM = 'system',
}

export interface INotification extends Document {
  userId: mongoose.Types.ObjectId;
  type: NotificationType;
  title: string;
  message: string;
  data?: Record<string, unknown>;
  isRead: boolean;
  readAt?: Date;
  createdAt: Date;
  updatedAt: Date;
}

const notificationSchema = new Schema<INotification>(
  {
    userId: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    type: { type: String, enum: Object.values(NotificationType), required: true },
    title: { type: String, required: true },
    message: { type: String, required: true },
    data: Schema.Types.Mixed,
    isRead: { type: Boolean, default: false },
    readAt: Date,
  },
  { timestamps: true }
);

notificationSchema.index({ userId: 1, isRead: 1, createdAt: -1 });

export const Notification = mongoose.model<INotification>('Notification', notificationSchema);
