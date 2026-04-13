import mongoose from 'mongoose';
import { connectDB, disconnectDB } from './config/database';

// Import all seed functions
import { seedUsers } from './seeds/user.seed';
import { seedReferrals } from './seeds/referral.seed';
import { seedCommissions } from './seeds/commission.seed';
import { seedKycApplications } from './seeds/kyc.seed';
import { seedPortfolios } from './seeds/portfolio.seed';
import { seedGoals } from './seeds/goal.seed';
import { seedAppointments } from './seeds/appointment.seed';
import { seedMarketingAssets } from './seeds/marketing.seed';
import { seedLeaderboard } from './seeds/leaderboard.seed';
import { seedCompanyValuations } from './seeds/valuation.seed';
import { seedShareholdings } from './seeds/shareholding.seed';
import { seedEducationContent } from './seeds/education.seed';
import { seedComplianceChecklists } from './seeds/compliance.seed';
import { seedNotifications } from './seeds/notification.seed';

async function cleanDatabase() {
  console.log('\n🗑️  Cleaning database...');
  const collections = await mongoose.connection.db!.listCollections().toArray();
  for (const collection of collections) {
    await mongoose.connection.db!.dropCollection(collection.name);
    console.log(`  Dropped: ${collection.name}`);
  }
  console.log('✓ Database cleaned\n');
}

async function runSeeds() {
  const args = process.argv.slice(2);
  const shouldClean = args.includes('--clean') || args.includes('--all');

  console.log('╔══════════════════════════════════════════╗');
  console.log('║   Client First Capital - Database Seed   ║');
  console.log('╚══════════════════════════════════════════╝\n');

  await connectDB();

  if (shouldClean) {
    await cleanDatabase();
  }

  if (args.includes('--clean') && !args.includes('--all')) {
    console.log('Database cleaned. Use --all to also re-seed.');
    await disconnectDB();
    return;
  }

  try {
    // Order matters: users first, then dependent collections
    console.log('📦 Seeding collections...\n');

    // 1. Foundation: Users
    await seedUsers();

    // 2. Introducer data
    await seedReferrals();
    await seedCommissions();
    await seedLeaderboard();

    // 3. Customer data
    await seedKycApplications();
    await seedPortfolios();
    await seedGoals();
    await seedAppointments();

    // 4. Advisor data
    await seedComplianceChecklists();

    // 5. Investor data
    await seedCompanyValuations();
    await seedShareholdings();

    // 6. Content & system
    await seedMarketingAssets();
    await seedEducationContent();
    await seedNotifications();

    console.log('\n✅ All seeds completed successfully!');

    // Print summary
    const collections = await mongoose.connection.db!.listCollections().toArray();
    console.log(`\n📊 Database Summary:`);
    for (const col of collections) {
      const count = await mongoose.connection.db!.collection(col.name).countDocuments();
      console.log(`   ${col.name}: ${count} documents`);
    }
  } catch (error) {
    console.error('\n❌ Seeding failed:', error);
    process.exit(1);
  }

  await disconnectDB();
}

runSeeds();
