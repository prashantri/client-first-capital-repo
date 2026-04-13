import { KycApplication, User, UserRole } from '../models';

export async function seedKycApplications() {
  console.log('Seeding KYC applications...');

  const pendingCustomer = await User.findOne({ role: UserRole.CUSTOMER, kycStatus: 'in_progress' });
  const pendingIntroducer = await User.findOne({ role: UserRole.INTRODUCER, kycStatus: 'submitted' });
  const admin = await User.findOne({ role: UserRole.ADMIN });

  const apps: any[] = [];

  if (pendingCustomer) {
    apps.push({
      userId: pendingCustomer._id,
      fullName: pendingCustomer.fullName,
      email: pendingCustomer.email,
      phone: pendingCustomer.phone,
      dateOfBirth: new Date('1992-07-08'),
      nationality: 'UAE',
      emiratesId: '784-1992-7654321-1',
      address: {
        line1: 'Apt 1205, Burj Views',
        city: 'Dubai',
        emirate: 'Dubai',
        country: 'UAE',
      },
      employmentStatus: 'Employed',
      employer: 'Emirates NBD',
      annualIncome: 'AED 300,000 - AED 500,000',
      sourceOfFunds: 'Employment Income',
      riskProfile: 'Moderate',
      investmentExperience: 'Intermediate',
      investmentObjective: 'Long-term wealth creation',
      status: 'in_progress',
    });
  }

  if (pendingIntroducer) {
    apps.push({
      userId: pendingIntroducer._id,
      fullName: pendingIntroducer.fullName,
      email: pendingIntroducer.email,
      phone: pendingIntroducer.phone,
      dateOfBirth: new Date('1987-04-12'),
      nationality: 'India',
      passportNumber: 'L1234567',
      address: {
        line1: 'Studio 34, Al Nahda',
        city: 'Sharjah',
        emirate: 'Sharjah',
        country: 'UAE',
      },
      employmentStatus: 'Self-Employed',
      annualIncome: 'AED 200,000 - AED 300,000',
      sourceOfFunds: 'Business Income',
      status: 'submitted',
      submittedAt: new Date('2026-04-10'),
      reviewedBy: admin?._id,
    });
  }

  if (!apps.length) {
    console.log('  ⚠ Skipping KYC applications - no pending users');
    return [];
  }

  const result = await KycApplication.insertMany(apps);
  console.log(`  ✓ ${result.length} KYC applications seeded`);
  return result;
}
