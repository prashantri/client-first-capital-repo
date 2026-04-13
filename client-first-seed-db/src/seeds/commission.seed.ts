import { Commission, CommissionType, CommissionStatus, Referral, ReferralStatus, User, UserRole } from '../models';

export async function seedCommissions() {
  console.log('Seeding commissions...');

  const introducers = await User.find({ role: UserRole.INTRODUCER, status: 'active' });
  const convertedReferrals = await Referral.find({ status: ReferralStatus.CONVERTED });

  if (!introducers.length || !convertedReferrals.length) {
    console.log('  ⚠ Skipping commissions - no data');
    return [];
  }

  const commissions = convertedReferrals.flatMap((referral) => [
    {
      introducerId: referral.introducerId,
      referralId: referral._id,
      type: CommissionType.REFERRAL_BONUS,
      amount: 5000,
      currency: 'AED',
      status: CommissionStatus.PAID,
      paymentDate: new Date(referral.convertedAt!.getTime() + 30 * 24 * 60 * 60 * 1000),
      paymentReference: `PAY-${Date.now()}-${Math.random().toString(36).slice(2, 7)}`,
    },
    {
      introducerId: referral.introducerId,
      referralId: referral._id,
      type: CommissionType.AUM_PERCENTAGE,
      amount: (referral.estimatedInvestment || 0) * 0.005,
      currency: 'AED',
      status: CommissionStatus.APPROVED,
      percentage: 0.5,
      aumGenerated: referral.estimatedInvestment,
      period: {
        startDate: new Date('2026-01-01'),
        endDate: new Date('2026-03-31'),
      },
    },
  ]);

  const result = await Commission.insertMany(commissions);
  console.log(`  ✓ ${result.length} commissions seeded`);
  return result;
}
