import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';

@Schema({ timestamps: true })
export class MarketingAsset extends Document {
  @Prop({ required: true, trim: true }) title: string;
  @Prop({ required: true }) description: string;
  @Prop({ required: true, enum: ['brochure', 'video', 'infographic', 'social_post', 'presentation', 'report'] }) type: string;
  @Prop({ required: true }) fileUrl: string;
  @Prop() thumbnailUrl?: string;
  @Prop({ required: true }) category: string;
  @Prop([String]) tags: string[];
  @Prop({ default: 0 }) downloadCount: number;
  @Prop({ default: true }) isActive: boolean;
  @Prop({ type: Types.ObjectId, ref: 'User', required: true }) createdBy: Types.ObjectId;
}

export const MarketingAssetSchema = SchemaFactory.createForClass(MarketingAsset);
MarketingAssetSchema.index({ type: 1, isActive: 1 });
