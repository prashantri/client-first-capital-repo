import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';
import { UserRole } from '../common/enums';

@Schema({ timestamps: true })
export class User extends Document {
  @Prop({ required: true, unique: true, lowercase: true, trim: true })
  email: string;

  @Prop({ required: true })
  passwordHash: string;

  @Prop({ required: true, trim: true })
  phone: string;

  @Prop({ required: true, trim: true })
  fullName: string;

  @Prop({ required: true, trim: true })
  firstName: string;

  @Prop({ required: true, trim: true })
  lastName: string;

  @Prop({ required: true, enum: UserRole })
  role: UserRole;

  @Prop({ default: 'pending', enum: ['pending', 'active', 'suspended', 'inactive'] })
  status: string;

  @Prop({ default: 'not_started', enum: ['not_started', 'in_progress', 'submitted', 'under_review', 'approved', 'rejected'] })
  kycStatus: string;

  @Prop()
  profileImageUrl?: string;

  @Prop()
  emiratesId?: string;

  @Prop()
  passportNumber?: string;

  @Prop()
  nationality?: string;

  @Prop()
  dateOfBirth?: Date;

  @Prop({ type: Object })
  address?: {
    line1: string;
    line2?: string;
    city: string;
    emirate: string;
    country: string;
    postalCode?: string;
  };

  @Prop({ unique: true, sparse: true })
  referralCode?: string;

  @Prop({ type: Types.ObjectId, ref: 'User' })
  referredBy?: Types.ObjectId;

  @Prop({ type: Types.ObjectId, ref: 'User' })
  assignedAdvisor?: Types.ObjectId;

  @Prop()
  lastLoginAt?: Date;

  @Prop()
  company?: string;

  @Prop()
  licenseNo?: string;

  @Prop({ type: Object })
  bankDetails?: {
    bankName: string;
    accountName: string;
    accountNumber: string;
    iban?: string;
  };
}

export const UserSchema = SchemaFactory.createForClass(User);
UserSchema.index({ role: 1, status: 1 });
UserSchema.index({ assignedAdvisor: 1 });
