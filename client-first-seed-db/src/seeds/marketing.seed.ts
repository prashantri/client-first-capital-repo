import { MarketingAsset, AssetType, User, UserRole } from '../models';

export async function seedMarketingAssets() {
  console.log('Seeding marketing assets...');

  const admin = await User.findOne({ role: UserRole.ADMIN });
  if (!admin) {
    console.log('  ⚠ Skipping marketing assets - no admin');
    return [];
  }

  const assets = [
    {
      title: 'Why Invest in UAE Markets - 2026 Outlook',
      description: 'A comprehensive overview of UAE investment opportunities for the year ahead.',
      type: AssetType.BROCHURE,
      fileUrl: '/assets/marketing/uae-markets-2026.pdf',
      category: 'Market Insights',
      tags: ['UAE', 'markets', '2026', 'outlook'],
      isActive: true,
      createdBy: admin._id,
    },
    {
      title: 'Client First Capital - Company Overview',
      description: 'Corporate brochure highlighting our services, team, and track record.',
      type: AssetType.BROCHURE,
      fileUrl: '/assets/marketing/company-overview.pdf',
      category: 'Corporate',
      tags: ['company', 'overview', 'services'],
      isActive: true,
      createdBy: admin._id,
    },
    {
      title: 'Power of Compounding - Visual Guide',
      description: 'Infographic showing how long-term disciplined investing creates wealth.',
      type: AssetType.INFOGRAPHIC,
      fileUrl: '/assets/marketing/compounding-guide.png',
      category: 'Education',
      tags: ['compounding', 'education', 'wealth'],
      isActive: true,
      downloadCount: 245,
      createdBy: admin._id,
    },
    {
      title: 'Retirement Planning Made Simple',
      description: 'Social media ready content about retirement planning strategies.',
      type: AssetType.SOCIAL_POST,
      fileUrl: '/assets/marketing/retirement-social.zip',
      category: 'Social Media',
      tags: ['retirement', 'social', 'planning'],
      isActive: true,
      downloadCount: 89,
      createdBy: admin._id,
    },
    {
      title: 'Q1 2026 Performance Report',
      description: 'Quarterly performance summary for clients and introducers.',
      type: AssetType.REPORT,
      fileUrl: '/assets/marketing/q1-2026-report.pdf',
      category: 'Reports',
      tags: ['quarterly', 'performance', 'Q1', '2026'],
      isActive: true,
      downloadCount: 156,
      createdBy: admin._id,
    },
    {
      title: 'How to Refer - Video Tutorial',
      description: 'Step-by-step video guide on using the referral system.',
      type: AssetType.VIDEO,
      fileUrl: '/assets/marketing/referral-tutorial.mp4',
      thumbnailUrl: '/assets/marketing/referral-tutorial-thumb.jpg',
      category: 'Training',
      tags: ['referral', 'tutorial', 'video'],
      isActive: true,
      downloadCount: 312,
      createdBy: admin._id,
    },
  ];

  const result = await MarketingAsset.insertMany(assets);
  console.log(`  ✓ ${result.length} marketing assets seeded`);
  return result;
}
