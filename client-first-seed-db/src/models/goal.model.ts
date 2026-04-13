import mongoose, { Schema, Document } from 'mongoose';

export enum GoalType {
  RETIREMENT = 'retirement',
  EDUCATION = 'education',
  HOME_PURCHASE = 'home_purchase',
  WEALTH_BUILDING = 'wealth_building',
  EMERGENCY_FUND = 'emergency_fund',
  CUSTOM = 'custom',
}

export enum GoalStatus {
  ACTIVE = 'active',
  PAUSED = 'paused',
  COMPLETED = 'completed',
  CANCELLED = 'cancelled',
}

export interface IGoal extends Document {
  customerId: mongoose.Types.ObjectId;
  name: string;
  type: GoalType;
  targetAmount: number;
  currentAmount: number;
  currency: string;
  targetDate: Date;
  monthlyContribution?: number;
  status: GoalStatus;
  progressPercent: number;
  notes?: string;
  createdAt: Date;
  updatedAt: Date;
}

const goalSchema = new Schema<IGoal>(
  {
    customerId: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    name: { type: String, required: true, trim: true },
    type: { type: String, enum: Object.values(GoalType), required: true },
    targetAmount: { type: Number, required: true },
    currentAmount: { type: Number, default: 0 },
    currency: { type: String, default: 'AED' },
    targetDate: { type: Date, required: true },
    monthlyContribution: Number,
    status: { type: String, enum: Object.values(GoalStatus), default: GoalStatus.ACTIVE },
    progressPercent: { type: Number, default: 0, min: 0, max: 100 },
    notes: String,
  },
  { timestamps: true }
);

goalSchema.index({ customerId: 1, status: 1 });

export const Goal = mongoose.model<IGoal>('Goal', goalSchema);
