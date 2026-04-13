import { Notification, NotificationType, User, UserRole } from '../models';

export async function seedNotifications() {
  console.log('Seeding notifications...');

  const users = await User.find({ status: 'active' }).limit(6);
  if (!users.length) {
    console.log('  ⚠ Skipping notifications - no users');
    return [];
  }

  const notifications = [
    {
      userId: users[0]._id,
      type: NotificationType.SYSTEM,
      title: 'Welcome to Client First Capital',
      message: 'Your account has been activated. Start exploring the platform!',
      isRead: true,
      readAt: new Date('2026-04-01'),
    },
    {
      userId: users[1]._id,
      type: NotificationType.REFERRAL_UPDATE,
      title: 'Referral Converted!',
      message: 'Your referral Ahmed Al Blooshi has been successfully converted to a client.',
      isRead: true,
      readAt: new Date('2025-09-16'),
    },
    {
      userId: users[1]._id,
      type: NotificationType.COMMISSION_PAID,
      title: 'Commission Payment Processed',
      message: 'AED 5,000 referral bonus has been credited to your account.',
      isRead: false,
    },
    {
      userId: users[2]._id,
      type: NotificationType.APPOINTMENT_REMINDER,
      title: 'Upcoming Appointment',
      message: 'You have a portfolio review with Michael Ross tomorrow at 10:00 AM.',
      isRead: false,
    },
    {
      userId: users[3]._id,
      type: NotificationType.PORTFOLIO_UPDATE,
      title: 'Portfolio Rebalanced',
      message: 'Your Growth Portfolio has been rebalanced as per the Q1 strategy.',
      isRead: true,
      readAt: new Date('2026-01-16'),
    },
    {
      userId: users[4]._id,
      type: NotificationType.EDUCATION_NEW,
      title: 'New Article: UAE Investment Landscape 2026',
      message: 'A new educational article has been published. Check it out!',
      isRead: false,
    },
    {
      userId: users[5]._id,
      type: NotificationType.MARKET_ALERT,
      title: 'Market Update: S&P 500 Rally',
      message: 'The S&P 500 gained 2.3% today. Your portfolio benefits from this movement.',
      isRead: false,
    },
  ];

  const result = await Notification.insertMany(notifications);
  console.log(`  ✓ ${result.length} notifications seeded`);
  return result;
}
