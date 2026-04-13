import { Referral, ReferralStatus, User, UserRole } from '../models';

export async function seedReferrals() {
  console.log('Seeding referrals...');

  const introducers = await User.find({ role: UserRole.INTRODUCER, status: 'active' });
  const advisors = await User.find({ role: UserRole.ADVISOR });
  const customers = await User.find({ role: UserRole.CUSTOMER, status: 'active' });

  if (!introducers.length || !advisors.length) {
    console.log('  ⚠ Skipping referrals - no introducers or advisors found');
    return [];
  }

  const referrals = [
    {
      introducerId: introducers[0]._id, // Sarah
      referralName: 'Ahmed Al Blooshi',
      referralEmail: 'ahmed.alblooshi@gmail.com',
      referralPhone: '+971501000030',
      status: ReferralStatus.CONVERTED,
      estimatedInvestment: 500000,
      assignedAdvisorId: advisors[0]._id,
      convertedCustomerId: customers[0]?._id,
      convertedAt: new Date('2025-09-15'),
      notes: 'High-net-worth individual, interested in diversified portfolio',
    },
    {
      introducerId: introducers[0]._id, // Sarah
      referralName: 'Priya Sharma',
      referralEmail: 'priya.sharma@gmail.com',
      referralPhone: '+971501000031',
      status: ReferralStatus.CONVERTED,
      estimatedInvestment: 250000,
      assignedAdvisorId: advisors[1]._id,
      convertedCustomerId: customers[1]?._id,
      convertedAt: new Date('2025-10-20'),
    },
    {
      introducerId: introducers[1]._id, // Omar
      referralName: 'David Wilson',
      referralEmail: 'david.wilson@gmail.com',
      referralPhone: '+971501000032',
      status: ReferralStatus.CONVERTED,
      estimatedInvestment: 750000,
      assignedAdvisorId: advisors[0]._id,
      convertedCustomerId: customers[2]?._id,
      convertedAt: new Date('2025-11-05'),
    },
    {
      introducerId: introducers[1]._id, // Omar
      referralName: 'Nadia Al Qasimi',
      referralEmail: 'nadia.alqasimi@gmail.com',
      referralPhone: '+971509876543',
      status: ReferralStatus.MEETING_SCHEDULED,
      estimatedInvestment: 300000,
      assignedAdvisorId: advisors[2]._id,
      followUpDate: new Date('2026-04-20'),
    },
    {
      introducerId: introducers[0]._id, // Sarah
      referralName: 'Ali Reza',
      referralEmail: 'ali.reza@gmail.com',
      referralPhone: '+971505551234',
      status: ReferralStatus.KYC_PENDING,
      estimatedInvestment: 150000,
      assignedAdvisorId: advisors[1]._id,
    },
    {
      introducerId: introducers[2]._id, // Fatima
      referralName: 'Chen Wei',
      referralEmail: 'chen.wei@gmail.com',
      referralPhone: '+971501000034',
      status: ReferralStatus.CONVERTED,
      estimatedInvestment: 1000000,
      assignedAdvisorId: advisors[0]._id,
      convertedCustomerId: customers[4]?._id,
      convertedAt: new Date('2025-12-10'),
    },
    {
      introducerId: introducers[2]._id, // Fatima
      referralName: 'Sofia Martinez',
      referralEmail: 'sofia.martinez@gmail.com',
      referralPhone: '+971507778899',
      status: ReferralStatus.CONTACTED,
      estimatedInvestment: 200000,
    },
    {
      introducerId: introducers[0]._id, // Sarah
      referralName: 'Mohammed Al Hashmi',
      referralEmail: 'mohammed.alhashmi@gmail.com',
      referralPhone: '+971504443322',
      status: ReferralStatus.NEW,
      estimatedInvestment: 400000,
      notes: 'Referred by existing client, interested in retirement planning',
    },
    {
      introducerId: introducers[1]._id, // Omar
      referralName: 'Layla Mohammed',
      referralEmail: 'layla.mohammed@gmail.com',
      referralPhone: '+971501000033',
      status: ReferralStatus.KYC_SUBMITTED,
      estimatedInvestment: 180000,
      assignedAdvisorId: advisors[2]._id,
    },
    {
      introducerId: introducers[2]._id, // Fatima
      referralName: 'Tom Anderson',
      referralEmail: 'tom.anderson@gmail.com',
      referralPhone: '+971506665544',
      status: ReferralStatus.NEW,
      estimatedInvestment: 600000,
    },
  ];

  const result = await Referral.insertMany(referrals);
  console.log(`  ✓ ${result.length} referrals seeded`);
  return result;
}
