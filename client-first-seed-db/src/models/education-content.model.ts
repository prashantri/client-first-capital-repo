import mongoose, { Schema, Document } from 'mongoose';

export interface IEducationContent extends Document {
  title: string;
  summary: string;
  content: string;
  category: string;
  author: string;
  thumbnailUrl?: string;
  readTimeMinutes: number;
  tags: string[];
  isPublished: boolean;
  publishedAt?: Date;
  viewCount: number;
  createdBy: mongoose.Types.ObjectId;
  createdAt: Date;
  updatedAt: Date;
}

const educationContentSchema = new Schema<IEducationContent>(
  {
    title: { type: String, required: true, trim: true },
    summary: { type: String, required: true },
    content: { type: String, required: true },
    category: { type: String, required: true },
    author: { type: String, required: true },
    thumbnailUrl: String,
    readTimeMinutes: { type: Number, default: 5 },
    tags: [String],
    isPublished: { type: Boolean, default: false },
    publishedAt: Date,
    viewCount: { type: Number, default: 0 },
    createdBy: { type: Schema.Types.ObjectId, ref: 'User', required: true },
  },
  { timestamps: true }
);

educationContentSchema.index({ category: 1, isPublished: 1 });
educationContentSchema.index({ tags: 1 });

export const EducationContent = mongoose.model<IEducationContent>('EducationContent', educationContentSchema);
