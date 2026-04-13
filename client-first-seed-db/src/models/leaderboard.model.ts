import mongoose, { Schema, Document } from 'mongoose';

export interface ILeaderboardEntry extends Document {
  introducerId: mongoose.Types.ObjectId;
  rank: number;
  totalReferrals: number;
  convertedReferrals: number;
  totalAumGenerated: number;
  totalCommissionsEarned: number;
  currency: string;
  period: string; // e.g., '2026-Q1', '2026-04', '2026'
  periodType: 'monthly' | 'quarterly' | 'yearly' | 'all_time';
  badges: string[];
  createdAt: Date;
  updatedAt: Date;
}

const leaderboardEntrySchema = new Schema<ILeaderboardEntry>(
  {
    introducerId: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    rank: { type: Number, required: true },
    totalReferrals: { type: Number, default: 0 },
    convertedReferrals: { type: Number, default: 0 },
    totalAumGenerated: { type: Number, default: 0 },
    totalCommissionsEarned: { type: Number, default: 0 },
    currency: { type: String, default: 'AED' },
    period: { type: String, required: true },
    periodType: { type: String, enum: ['monthly', 'quarterly', 'yearly', 'all_time'], required: true },
    badges: [String],
  },
  { timestamps: true }
);

leaderboardEntrySchema.index({ periodType: 1, period: 1, rank: 1 });
leaderboardEntrySchema.index({ introducerId: 1 });

export const LeaderboardEntry = mongoose.model<ILeaderboardEntry>('LeaderboardEntry', leaderboardEntrySchema);
