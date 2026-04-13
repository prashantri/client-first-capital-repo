import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';

@Schema({ timestamps: true })
export class Shareholding extends Document {
  @Prop({ type: Types.ObjectId, ref: 'User', required: true }) investorId: Types.ObjectId;
  @Prop({ required: true }) sharesHeld: number;
  @Prop({ required: true, default: 'Class A' }) shareClass: string;
  @Prop({ required: true }) ownershipPercent: number;
  @Prop({ required: true }) purchasePrice: number;
  @Prop({ required: true }) currentValuePerShare: number;
  @Prop({ required: true }) totalValue: number;
  @Prop({ default: 'AED' }) currency: string;
  @Prop({ required: true }) purchaseDate: Date;
  @Prop() certificateUrl?: string;
}

export const ShareholdingSchema = SchemaFactory.createForClass(Shareholding);
ShareholdingSchema.index({ investorId: 1 });
