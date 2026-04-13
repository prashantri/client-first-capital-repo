import { Goal, GoalType, GoalStatus, User, UserRole } from '../models';

export async function seedGoals() {
  console.log('Seeding goals...');

  const customers = await User.find({ role: UserRole.CUSTOMER, status: 'active' });
  if (!customers.length) {
    console.log('  ⚠ Skipping goals - no customers');
    return [];
  }

  const goals = [
    {
      customerId: customers[0]._id,
      name: 'Retirement Fund',
      type: GoalType.RETIREMENT,
      targetAmount: 2000000,
      currentAmount: 350000,
      currency: 'AED',
      targetDate: new Date('2045-01-01'),
      monthlyContribution: 8000,
      status: GoalStatus.ACTIVE,
      progressPercent: 17.5,
    },
    {
      customerId: customers[0]._id,
      name: "Children's Education",
      type: GoalType.EDUCATION,
      targetAmount: 500000,
      currentAmount: 125000,
      currency: 'AED',
      targetDate: new Date('2035-09-01'),
      monthlyContribution: 3500,
      status: GoalStatus.ACTIVE,
      progressPercent: 25,
    },
    {
      customerId: customers[1]._id,
      name: 'Dream Home',
      type: GoalType.HOME_PURCHASE,
      targetAmount: 1500000,
      currentAmount: 180000,
      currency: 'AED',
      targetDate: new Date('2030-06-01'),
      monthlyContribution: 12000,
      status: GoalStatus.ACTIVE,
      progressPercent: 12,
    },
    {
      customerId: customers[2]._id,
      name: 'Wealth Building',
      type: GoalType.WEALTH_BUILDING,
      targetAmount: 5000000,
      currentAmount: 720000,
      currency: 'AED',
      targetDate: new Date('2040-01-01'),
      monthlyContribution: 20000,
      status: GoalStatus.ACTIVE,
      progressPercent: 14.4,
    },
    {
      customerId: customers[1]._id,
      name: 'Emergency Fund',
      type: GoalType.EMERGENCY_FUND,
      targetAmount: 100000,
      currentAmount: 85000,
      currency: 'AED',
      targetDate: new Date('2026-12-31'),
      monthlyContribution: 5000,
      status: GoalStatus.ACTIVE,
      progressPercent: 85,
    },
  ];

  const result = await Goal.insertMany(goals);
  console.log(`  ✓ ${result.length} goals seeded`);
  return result;
}
