import mongoose, { Schema, Document } from 'mongoose';

export enum ReferralStatus {
  NEW = 'new',
  CONTACTED = 'contacted',
  MEETING_SCHEDULED = 'meeting_scheduled',
  KYC_PENDING = 'kyc_pending',
  KYC_SUBMITTED = 'kyc_submitted',
  CONVERTED = 'converted',
  LOST = 'lost',
}

export interface IReferral extends Document {
  introducerId: mongoose.Types.ObjectId;
  referralName: string;
  referralEmail: string;
  referralPhone: string;
  status: ReferralStatus;
  notes?: string;
  estimatedInvestment?: number;
  currency: string;
  assignedAdvisorId?: mongoose.Types.ObjectId;
  convertedCustomerId?: mongoose.Types.ObjectId;
  source?: string;
  tags?: string[];
  followUpDate?: Date;
  convertedAt?: Date;
  createdAt: Date;
  updatedAt: Date;
}

const referralSchema = new Schema<IReferral>(
  {
    introducerId: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    referralName: { type: String, required: true, trim: true },
    referralEmail: { type: String, required: true, lowercase: true, trim: true },
    referralPhone: { type: String, required: true, trim: true },
    status: { type: String, enum: Object.values(ReferralStatus), default: ReferralStatus.NEW },
    notes: String,
    estimatedInvestment: Number,
    currency: { type: String, default: 'AED' },
    assignedAdvisorId: { type: Schema.Types.ObjectId, ref: 'User' },
    convertedCustomerId: { type: Schema.Types.ObjectId, ref: 'User' },
    source: String,
    tags: [String],
    followUpDate: Date,
    convertedAt: Date,
  },
  { timestamps: true }
);

referralSchema.index({ introducerId: 1, status: 1 });
referralSchema.index({ assignedAdvisorId: 1 });
referralSchema.index({ status: 1 });

export const Referral = mongoose.model<IReferral>('Referral', referralSchema);
