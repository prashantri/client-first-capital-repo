import { Shareholding, User, UserRole } from '../models';

export async function seedShareholdings() {
  console.log('Seeding shareholdings...');

  const investors = await User.find({ role: UserRole.INVESTOR });
  if (!investors.length) {
    console.log('  ⚠ Skipping shareholdings - no investors');
    return [];
  }

  const shareholdings = [
    {
      investorId: investors[0]._id, // Khalid
      sharesHeld: 50000,
      shareClass: 'Class A',
      ownershipPercent: 15.5,
      purchasePrice: 10,
      currentValuePerShare: 17.05,
      totalValue: 852500,
      currency: 'AED',
      purchaseDate: new Date('2024-06-15'),
    },
    {
      investorId: investors[1]._id, // Richard
      sharesHeld: 30000,
      shareClass: 'Class A',
      ownershipPercent: 9.3,
      purchasePrice: 12,
      currentValuePerShare: 17.05,
      totalValue: 511500,
      currency: 'AED',
      purchaseDate: new Date('2025-01-10'),
    },
  ];

  const result = await Shareholding.insertMany(shareholdings);
  console.log(`  ✓ ${result.length} shareholdings seeded`);
  return result;
}
