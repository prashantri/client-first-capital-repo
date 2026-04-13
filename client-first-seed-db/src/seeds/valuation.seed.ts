import { CompanyValuation, User, UserRole } from '../models';

export async function seedCompanyValuations() {
  console.log('Seeding company valuations...');

  const admin = await User.findOne({ role: UserRole.ADMIN });
  if (!admin) {
    console.log('  ⚠ Skipping valuations - no admin');
    return [];
  }

  const valuations = [
    {
      valuationAmount: 25000000,
      totalAum: 120000000,
      activeClients: 850,
      growthPercent: 0,
      period: 'Q1 2025',
      valuationDate: new Date('2025-03-31'),
      notes: 'Initial valuation at Series A',
      createdBy: admin._id,
    },
    {
      valuationAmount: 32000000,
      totalAum: 180000000,
      activeClients: 1200,
      growthPercent: 28,
      period: 'Q2 2025',
      valuationDate: new Date('2025-06-30'),
      createdBy: admin._id,
    },
    {
      valuationAmount: 40000000,
      totalAum: 240000000,
      activeClients: 1650,
      growthPercent: 25,
      period: 'Q3 2025',
      valuationDate: new Date('2025-09-30'),
      createdBy: admin._id,
    },
    {
      valuationAmount: 50000000,
      totalAum: 320000000,
      activeClients: 2450,
      growthPercent: 8.7,
      period: 'Q4 2025',
      valuationDate: new Date('2025-12-31'),
      reportUrl: '/reports/q4-2025-valuation.pdf',
      createdBy: admin._id,
    },
    {
      valuationAmount: 55000000,
      totalAum: 380000000,
      activeClients: 2800,
      growthPercent: 10,
      period: 'Q1 2026',
      valuationDate: new Date('2026-03-31'),
      reportUrl: '/reports/q1-2026-valuation.pdf',
      notes: 'Strong growth in UAE and GCC markets',
      createdBy: admin._id,
    },
  ];

  const result = await CompanyValuation.insertMany(valuations);
  console.log(`  ✓ ${result.length} company valuations seeded`);
  return result;
}
