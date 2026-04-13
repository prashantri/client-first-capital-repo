import mongoose, { Schema, Document } from 'mongoose';

export enum AppointmentStatus {
  REQUESTED = 'requested',
  CONFIRMED = 'confirmed',
  COMPLETED = 'completed',
  CANCELLED = 'cancelled',
  NO_SHOW = 'no_show',
}

export enum AppointmentType {
  INITIAL_CONSULTATION = 'initial_consultation',
  PORTFOLIO_REVIEW = 'portfolio_review',
  RISK_ASSESSMENT = 'risk_assessment',
  GOAL_PLANNING = 'goal_planning',
  GENERAL = 'general',
}

export interface IAppointment extends Document {
  customerId: mongoose.Types.ObjectId;
  advisorId: mongoose.Types.ObjectId;
  type: AppointmentType;
  status: AppointmentStatus;
  scheduledAt: Date;
  durationMinutes: number;
  location?: string;
  meetingLink?: string;
  notes?: string;
  advisorNotes?: string;
  cancelledReason?: string;
  completedAt?: Date;
  createdAt: Date;
  updatedAt: Date;
}

const appointmentSchema = new Schema<IAppointment>(
  {
    customerId: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    advisorId: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    type: { type: String, enum: Object.values(AppointmentType), required: true },
    status: { type: String, enum: Object.values(AppointmentStatus), default: AppointmentStatus.REQUESTED },
    scheduledAt: { type: Date, required: true },
    durationMinutes: { type: Number, default: 30 },
    location: String,
    meetingLink: String,
    notes: String,
    advisorNotes: String,
    cancelledReason: String,
    completedAt: Date,
  },
  { timestamps: true }
);

appointmentSchema.index({ customerId: 1, scheduledAt: -1 });
appointmentSchema.index({ advisorId: 1, scheduledAt: -1 });
appointmentSchema.index({ status: 1 });

export const Appointment = mongoose.model<IAppointment>('Appointment', appointmentSchema);
