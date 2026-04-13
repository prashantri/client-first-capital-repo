import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';

@Schema({ timestamps: true })
export class Appointment extends Document {
  @Prop({ type: Types.ObjectId, ref: 'User', required: true })
  customerId: Types.ObjectId;

  @Prop({ type: Types.ObjectId, ref: 'User', required: true })
  advisorId: Types.ObjectId;

  @Prop({ required: true, enum: ['initial_consultation', 'portfolio_review', 'risk_assessment', 'goal_planning', 'general'] })
  type: string;

  @Prop({ default: 'requested', enum: ['requested', 'confirmed', 'completed', 'cancelled', 'no_show'] })
  status: string;

  @Prop({ required: true }) scheduledAt: Date;
  @Prop({ default: 30 }) durationMinutes: number;
  @Prop() location?: string;
  @Prop() meetingLink?: string;
  @Prop() notes?: string;
  @Prop() advisorNotes?: string;
  @Prop() cancelledReason?: string;
  @Prop() completedAt?: Date;
}

export const AppointmentSchema = SchemaFactory.createForClass(Appointment);
AppointmentSchema.index({ customerId: 1, scheduledAt: -1 });
AppointmentSchema.index({ advisorId: 1, scheduledAt: -1 });
