import { ComplianceChecklist, User, UserRole } from '../models';

export async function seedComplianceChecklists() {
  console.log('Seeding compliance checklists...');

  const advisors = await User.find({ role: UserRole.ADVISOR });
  if (!advisors.length) {
    console.log('  ⚠ Skipping compliance - no advisors');
    return [];
  }

  const checklists = advisors.flatMap((advisor) => [
    {
      advisorId: advisor._id,
      title: 'KYC Verification Complete',
      description: 'Ensure all client KYC documents are verified and up to date.',
      category: 'KYC',
      isCompleted: true,
      completedAt: new Date('2026-03-01'),
    },
    {
      advisorId: advisor._id,
      title: 'Risk Disclosure Signed',
      description: 'Client has signed the risk disclosure and investment warning form.',
      category: 'Documentation',
      isCompleted: true,
      completedAt: new Date('2026-03-05'),
    },
    {
      advisorId: advisor._id,
      title: 'Quarterly Portfolio Review',
      description: 'Complete quarterly portfolio review with all active clients.',
      category: 'Review',
      isCompleted: false,
      dueDate: new Date('2026-04-30'),
    },
    {
      advisorId: advisor._id,
      title: 'Anti-Money Laundering Check',
      description: 'Run AML screening on all new clients this quarter.',
      category: 'AML',
      isCompleted: false,
      dueDate: new Date('2026-04-15'),
    },
    {
      advisorId: advisor._id,
      title: 'Suitability Assessment Update',
      description: 'Update suitability assessments for clients with risk profile changes.',
      category: 'Suitability',
      isCompleted: false,
      dueDate: new Date('2026-05-01'),
    },
  ]);

  const result = await ComplianceChecklist.insertMany(checklists);
  console.log(`  ✓ ${result.length} compliance items seeded`);
  return result;
}
