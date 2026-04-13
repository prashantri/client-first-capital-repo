import mongoose, { Schema, Document } from 'mongoose';

export interface IKycApplication extends Document {
  userId: mongoose.Types.ObjectId;
  // Step 1: Personal Information
  fullName: string;
  email: string;
  phone: string;
  dateOfBirth: Date;
  nationality: string;
  // Step 2: Identity Verification
  emiratesId?: string;
  passportNumber?: string;
  emiratesIdFrontUrl?: string;
  emiratesIdBackUrl?: string;
  passportUrl?: string;
  selfieUrl?: string;
  // Step 3: Address & Financial
  address: {
    line1: string;
    line2?: string;
    city: string;
    emirate: string;
    country: string;
    postalCode?: string;
  };
  employmentStatus?: string;
  employer?: string;
  annualIncome?: string;
  sourceOfFunds?: string;
  // Risk Profile
  riskProfile?: string;
  investmentExperience?: string;
  investmentObjective?: string;
  // Status & Review
  status: string;
  reviewedBy?: mongoose.Types.ObjectId;
  reviewNotes?: string;
  rejectionReason?: string;
  submittedAt?: Date;
  reviewedAt?: Date;
  approvedAt?: Date;
  createdAt: Date;
  updatedAt: Date;
}

const kycApplicationSchema = new Schema<IKycApplication>(
  {
    userId: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    fullName: { type: String, required: true, trim: true },
    email: { type: String, required: true, lowercase: true, trim: true },
    phone: { type: String, required: true, trim: true },
    dateOfBirth: Date,
    nationality: String,
    emiratesId: String,
    passportNumber: String,
    emiratesIdFrontUrl: String,
    emiratesIdBackUrl: String,
    passportUrl: String,
    selfieUrl: String,
    address: {
      line1: String,
      line2: String,
      city: String,
      emirate: String,
      country: String,
      postalCode: String,
    },
    employmentStatus: String,
    employer: String,
    annualIncome: String,
    sourceOfFunds: String,
    riskProfile: String,
    investmentExperience: String,
    investmentObjective: String,
    status: {
      type: String,
      enum: ['not_started', 'in_progress', 'submitted', 'under_review', 'approved', 'rejected'],
      default: 'not_started',
    },
    reviewedBy: { type: Schema.Types.ObjectId, ref: 'User' },
    reviewNotes: String,
    rejectionReason: String,
    submittedAt: Date,
    reviewedAt: Date,
    approvedAt: Date,
  },
  { timestamps: true }
);

kycApplicationSchema.index({ userId: 1 });
kycApplicationSchema.index({ status: 1 });

export const KycApplication = mongoose.model<IKycApplication>('KycApplication', kycApplicationSchema);
