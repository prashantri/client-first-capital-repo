import mongoose, { Schema, Document } from 'mongoose';

export enum AssetType {
  BROCHURE = 'brochure',
  VIDEO = 'video',
  INFOGRAPHIC = 'infographic',
  SOCIAL_POST = 'social_post',
  PRESENTATION = 'presentation',
  REPORT = 'report',
}

export interface IMarketingAsset extends Document {
  title: string;
  description: string;
  type: AssetType;
  fileUrl: string;
  thumbnailUrl?: string;
  category: string;
  tags: string[];
  downloadCount: number;
  isActive: boolean;
  createdBy: mongoose.Types.ObjectId;
  createdAt: Date;
  updatedAt: Date;
}

const marketingAssetSchema = new Schema<IMarketingAsset>(
  {
    title: { type: String, required: true, trim: true },
    description: { type: String, required: true },
    type: { type: String, enum: Object.values(AssetType), required: true },
    fileUrl: { type: String, required: true },
    thumbnailUrl: String,
    category: { type: String, required: true },
    tags: [String],
    downloadCount: { type: Number, default: 0 },
    isActive: { type: Boolean, default: true },
    createdBy: { type: Schema.Types.ObjectId, ref: 'User', required: true },
  },
  { timestamps: true }
);

marketingAssetSchema.index({ type: 1, isActive: 1 });
marketingAssetSchema.index({ category: 1 });

export const MarketingAsset = mongoose.model<IMarketingAsset>('MarketingAsset', marketingAssetSchema);
