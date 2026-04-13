import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';

@Schema({ timestamps: true })
export class ComplianceChecklist extends Document {
  @Prop({ type: Types.ObjectId, ref: 'User', required: true }) advisorId: Types.ObjectId;
  @Prop({ required: true, trim: true }) title: string;
  @Prop({ required: true }) description: string;
  @Prop({ required: true }) category: string;
  @Prop({ default: false }) isCompleted: boolean;
  @Prop() dueDate?: Date;
  @Prop() completedAt?: Date;
  @Prop() notes?: string;
}

export const ComplianceChecklistSchema = SchemaFactory.createForClass(ComplianceChecklist);
ComplianceChecklistSchema.index({ advisorId: 1, isCompleted: 1 });
