import { LeaderboardEntry, User, UserRole } from '../models';

export async function seedLeaderboard() {
  console.log('Seeding leaderboard...');

  const introducers = await User.find({ role: UserRole.INTRODUCER, status: 'active' });
  if (!introducers.length) {
    console.log('  ⚠ Skipping leaderboard - no introducers');
    return [];
  }

  const entries = [
    // Q1 2026 Quarterly
    {
      introducerId: introducers[0]._id, // Sarah
      rank: 1,
      totalReferrals: 12,
      convertedReferrals: 8,
      totalAumGenerated: 4500000,
      totalCommissionsEarned: 25000,
      period: '2026-Q1',
      periodType: 'quarterly' as const,
      badges: ['Top Performer', 'Star Introducer', 'AUM Champion'],
    },
    {
      introducerId: introducers[2]._id, // Fatima
      rank: 2,
      totalReferrals: 9,
      convertedReferrals: 5,
      totalAumGenerated: 3200000,
      totalCommissionsEarned: 18000,
      period: '2026-Q1',
      periodType: 'quarterly' as const,
      badges: ['Rising Star'],
    },
    {
      introducerId: introducers[1]._id, // Omar
      rank: 3,
      totalReferrals: 7,
      convertedReferrals: 4,
      totalAumGenerated: 2100000,
      totalCommissionsEarned: 12000,
      period: '2026-Q1',
      periodType: 'quarterly' as const,
      badges: [],
    },
    // All-time
    {
      introducerId: introducers[0]._id,
      rank: 1,
      totalReferrals: 45,
      convertedReferrals: 32,
      totalAumGenerated: 12500000,
      totalCommissionsEarned: 85000,
      period: 'all',
      periodType: 'all_time' as const,
      badges: ['Top Performer', 'Star Introducer', 'AUM Champion', 'Veteran'],
    },
    {
      introducerId: introducers[1]._id,
      rank: 2,
      totalReferrals: 38,
      convertedReferrals: 25,
      totalAumGenerated: 8900000,
      totalCommissionsEarned: 62000,
      period: 'all',
      periodType: 'all_time' as const,
      badges: ['Star Introducer', 'Consistent Performer'],
    },
    {
      introducerId: introducers[2]._id,
      rank: 3,
      totalReferrals: 20,
      convertedReferrals: 14,
      totalAumGenerated: 5600000,
      totalCommissionsEarned: 35000,
      period: 'all',
      periodType: 'all_time' as const,
      badges: ['Rising Star'],
    },
  ];

  const result = await LeaderboardEntry.insertMany(entries);
  console.log(`  ✓ ${result.length} leaderboard entries seeded`);
  return result;
}
