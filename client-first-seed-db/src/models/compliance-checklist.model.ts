import mongoose, { Schema, Document } from 'mongoose';

export interface IComplianceChecklist extends Document {
  advisorId: mongoose.Types.ObjectId;
  title: string;
  description: string;
  category: string;
  isCompleted: boolean;
  dueDate?: Date;
  completedAt?: Date;
  notes?: string;
  createdAt: Date;
  updatedAt: Date;
}

const complianceChecklistSchema = new Schema<IComplianceChecklist>(
  {
    advisorId: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    title: { type: String, required: true, trim: true },
    description: { type: String, required: true },
    category: { type: String, required: true },
    isCompleted: { type: Boolean, default: false },
    dueDate: Date,
    completedAt: Date,
    notes: String,
  },
  { timestamps: true }
);

complianceChecklistSchema.index({ advisorId: 1, isCompleted: 1 });

export const ComplianceChecklist = mongoose.model<IComplianceChecklist>('ComplianceChecklist', complianceChecklistSchema);
