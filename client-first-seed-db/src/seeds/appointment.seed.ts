import { Appointment, AppointmentType, AppointmentStatus, User, UserRole } from '../models';

export async function seedAppointments() {
  console.log('Seeding appointments...');

  const customers = await User.find({ role: UserRole.CUSTOMER, status: 'active' });
  const advisors = await User.find({ role: UserRole.ADVISOR });

  if (!customers.length || !advisors.length) {
    console.log('  ⚠ Skipping appointments - no data');
    return [];
  }

  const appointments = [
    {
      customerId: customers[0]._id,
      advisorId: advisors[0]._id,
      type: AppointmentType.PORTFOLIO_REVIEW,
      status: AppointmentStatus.CONFIRMED,
      scheduledAt: new Date('2026-04-18T10:00:00'),
      durationMinutes: 45,
      location: 'DIFC Office, Meeting Room 3',
      notes: 'Q1 portfolio review and rebalancing discussion',
    },
    {
      customerId: customers[1]._id,
      advisorId: advisors[1]._id,
      type: AppointmentType.GOAL_PLANNING,
      status: AppointmentStatus.CONFIRMED,
      scheduledAt: new Date('2026-04-20T14:00:00'),
      durationMinutes: 60,
      meetingLink: 'https://meet.google.com/abc-defg-hij',
      notes: 'Review home purchase goal progress',
    },
    {
      customerId: customers[2]._id,
      advisorId: advisors[0]._id,
      type: AppointmentType.RISK_ASSESSMENT,
      status: AppointmentStatus.COMPLETED,
      scheduledAt: new Date('2026-03-25T11:00:00'),
      durationMinutes: 30,
      completedAt: new Date('2026-03-25T11:35:00'),
      advisorNotes: 'Client comfortable with aggressive strategy. Reviewed market volatility scenarios.',
    },
    {
      customerId: customers[0]._id,
      advisorId: advisors[0]._id,
      type: AppointmentType.INITIAL_CONSULTATION,
      status: AppointmentStatus.COMPLETED,
      scheduledAt: new Date('2025-06-10T09:00:00'),
      durationMinutes: 60,
      completedAt: new Date('2025-06-10T10:05:00'),
      advisorNotes: 'Onboarded successfully. Risk profile: Moderate. Starting with AED 300K.',
    },
    {
      customerId: customers[3]._id,
      advisorId: advisors[0]._id,
      type: AppointmentType.PORTFOLIO_REVIEW,
      status: AppointmentStatus.REQUESTED,
      scheduledAt: new Date('2026-04-25T15:00:00'),
      durationMinutes: 45,
      notes: 'Annual review requested by client',
    },
  ];

  const result = await Appointment.insertMany(appointments);
  console.log(`  ✓ ${result.length} appointments seeded`);
  return result;
}
