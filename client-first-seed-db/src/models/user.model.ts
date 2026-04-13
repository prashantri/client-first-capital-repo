import mongoose, { Schema, Document } from 'mongoose';

export enum UserRole {
  INTRODUCER = 'introducer',
  ADVISOR = 'advisor',
  CUSTOMER = 'customer',
  INVESTOR = 'investor',
  ADMIN = 'admin',
}

export enum UserStatus {
  PENDING = 'pending',
  ACTIVE = 'active',
  SUSPENDED = 'suspended',
  INACTIVE = 'inactive',
}

export enum KycStatus {
  NOT_STARTED = 'not_started',
  IN_PROGRESS = 'in_progress',
  SUBMITTED = 'submitted',
  UNDER_REVIEW = 'under_review',
  APPROVED = 'approved',
  REJECTED = 'rejected',
}

export interface IUser extends Document {
  email: string;
  passwordHash: string;
  phone: string;
  fullName: string;
  firstName: string;
  lastName: string;
  role: UserRole;
  status: UserStatus;
  kycStatus: KycStatus;
  profileImageUrl?: string;
  emiratesId?: string;
  passportNumber?: string;
  nationality?: string;
  dateOfBirth?: Date;
  address?: {
    line1: string;
    line2?: string;
    city: string;
    emirate: string;
    country: string;
    postalCode?: string;
  };
  referralCode?: string;
  referredBy?: mongoose.Types.ObjectId;
  assignedAdvisor?: mongoose.Types.ObjectId;
  lastLoginAt?: Date;
  createdAt: Date;
  updatedAt: Date;
}

const userSchema = new Schema<IUser>(
  {
    email: { type: String, required: true, unique: true, lowercase: true, trim: true },
    passwordHash: { type: String, required: true },
    phone: { type: String, required: true, trim: true },
    fullName: { type: String, required: true, trim: true },
    firstName: { type: String, required: true, trim: true },
    lastName: { type: String, required: true, trim: true },
    role: { type: String, enum: Object.values(UserRole), required: true },
    status: { type: String, enum: Object.values(UserStatus), default: UserStatus.PENDING },
    kycStatus: { type: String, enum: Object.values(KycStatus), default: KycStatus.NOT_STARTED },
    profileImageUrl: String,
    emiratesId: String,
    passportNumber: String,
    nationality: String,
    dateOfBirth: Date,
    address: {
      line1: String,
      line2: String,
      city: String,
      emirate: String,
      country: String,
      postalCode: String,
    },
    referralCode: { type: String, unique: true, sparse: true },
    referredBy: { type: Schema.Types.ObjectId, ref: 'User' },
    assignedAdvisor: { type: Schema.Types.ObjectId, ref: 'User' },
    lastLoginAt: Date,
  },
  { timestamps: true }
);

userSchema.index({ role: 1, status: 1 });
userSchema.index({ assignedAdvisor: 1 });

export const User = mongoose.model<IUser>('User', userSchema);
