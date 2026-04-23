import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';

@Schema({ timestamps: true })
export class KycApplication extends Document {
  @Prop({ type: Types.ObjectId, ref: 'User', required: true })
  userId: Types.ObjectId;

  @Prop({ required: true, trim: true }) fullName: string;
  @Prop({ required: true, lowercase: true, trim: true }) email: string;
  @Prop({ required: true, trim: true }) phone: string;
  @Prop() dateOfBirth?: Date;
  @Prop() nationality?: string;
  @Prop() emiratesId?: string;
  @Prop() passportNumber?: string;
  @Prop() emiratesIdFrontUrl?: string;
  @Prop() emiratesIdBackUrl?: string;
  @Prop() passportUrl?: string;
  @Prop() selfieUrl?: string;

  @Prop({ type: Map, of: Object, default: {} })
  documents: Map<string, { fileName: string; mimeType: string; data: string; uploadedAt: Date }>;

  @Prop({ type: Object })
  address?: { line1: string; line2?: string; city: string; emirate: string; country: string; postalCode?: string };

  @Prop() employmentStatus?: string;
  @Prop() employer?: string;
  @Prop() annualIncome?: string;
  @Prop() sourceOfFunds?: string;
  @Prop() riskProfile?: string;
  @Prop() investmentExperience?: string;
  @Prop() investmentObjective?: string;

  @Prop({ default: 'not_started', enum: ['not_started', 'in_progress', 'submitted', 'under_review', 'approved', 'rejected'] })
  status: string;

  @Prop({ type: Types.ObjectId, ref: 'User' }) reviewedBy?: Types.ObjectId;
  @Prop() reviewNotes?: string;
  @Prop() rejectionReason?: string;
  @Prop() submittedAt?: Date;
  @Prop() reviewedAt?: Date;
  @Prop() approvedAt?: Date;
}

export const KycApplicationSchema = SchemaFactory.createForClass(KycApplication);
KycApplicationSchema.index({ userId: 1 });
KycApplicationSchema.index({ status: 1 });
