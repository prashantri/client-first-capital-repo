import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';

@Schema({ timestamps: true })
export class LeaderboardEntry extends Document {
  @Prop({ type: Types.ObjectId, ref: 'User', required: true }) introducerId: Types.ObjectId;
  @Prop({ required: true }) rank: number;
  @Prop({ default: 0 }) totalReferrals: number;
  @Prop({ default: 0 }) convertedReferrals: number;
  @Prop({ default: 0 }) totalAumGenerated: number;
  @Prop({ default: 0 }) totalCommissionsEarned: number;
  @Prop({ default: 'AED' }) currency: string;
  @Prop({ required: true }) period: string;
  @Prop({ required: true, enum: ['monthly', 'quarterly', 'yearly', 'all_time'] }) periodType: string;
  @Prop([String]) badges: string[];
}

export const LeaderboardEntrySchema = SchemaFactory.createForClass(LeaderboardEntry);
LeaderboardEntrySchema.index({ periodType: 1, period: 1, rank: 1 });
