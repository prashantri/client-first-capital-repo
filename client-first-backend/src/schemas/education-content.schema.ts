import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';

@Schema({ timestamps: true })
export class EducationContent extends Document {
  @Prop({ required: true, trim: true }) title: string;
  @Prop({ required: true }) summary: string;
  @Prop({ required: true }) content: string;
  @Prop({ required: true }) category: string;
  @Prop({ required: true }) author: string;
  @Prop() thumbnailUrl?: string;
  @Prop({ default: 5 }) readTimeMinutes: number;
  @Prop([String]) tags: string[];
  @Prop({ default: false }) isPublished: boolean;
  @Prop() publishedAt?: Date;
  @Prop({ default: 0 }) viewCount: number;
  @Prop({ type: Types.ObjectId, ref: 'User', required: true }) createdBy: Types.ObjectId;
}

export const EducationContentSchema = SchemaFactory.createForClass(EducationContent);
EducationContentSchema.index({ category: 1, isPublished: 1 });
