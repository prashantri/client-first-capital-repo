import mongoose, { Schema, Document } from 'mongoose';

export enum CommissionType {
  REFERRAL_BONUS = 'referral_bonus',
  AUM_PERCENTAGE = 'aum_percentage',
  PERFORMANCE_BONUS = 'performance_bonus',
}

export enum CommissionStatus {
  PENDING = 'pending',
  APPROVED = 'approved',
  PAID = 'paid',
  CANCELLED = 'cancelled',
}

export interface ICommission extends Document {
  introducerId: mongoose.Types.ObjectId;
  referralId: mongoose.Types.ObjectId;
  type: CommissionType;
  amount: number;
  currency: string;
  status: CommissionStatus;
  percentage?: number;
  aumGenerated?: number;
  paymentDate?: Date;
  paymentReference?: string;
  period?: {
    startDate: Date;
    endDate: Date;
  };
  createdAt: Date;
  updatedAt: Date;
}

const commissionSchema = new Schema<ICommission>(
  {
    introducerId: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    referralId: { type: Schema.Types.ObjectId, ref: 'Referral', required: true },
    type: { type: String, enum: Object.values(CommissionType), required: true },
    amount: { type: Number, required: true },
    currency: { type: String, default: 'AED' },
    status: { type: String, enum: Object.values(CommissionStatus), default: CommissionStatus.PENDING },
    percentage: Number,
    aumGenerated: Number,
    paymentDate: Date,
    paymentReference: String,
    period: {
      startDate: Date,
      endDate: Date,
    },
  },
  { timestamps: true }
);

commissionSchema.index({ introducerId: 1, status: 1 });
commissionSchema.index({ status: 1 });

export const Commission = mongoose.model<ICommission>('Commission', commissionSchema);
