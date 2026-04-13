import { EducationContent, User, UserRole } from '../models';

export async function seedEducationContent() {
  console.log('Seeding education content...');

  const admin = await User.findOne({ role: UserRole.ADMIN });
  if (!admin) {
    console.log('  ⚠ Skipping education content - no admin');
    return [];
  }

  const content = [
    {
      title: 'The Power of Compound Interest',
      summary: 'Understanding how compound interest works and why starting early matters.',
      content: 'Compound interest is the eighth wonder of the world. He who understands it, earns it; he who doesn\'t, pays it. This principle is the foundation of long-term wealth building...',
      category: 'Fundamentals',
      author: 'Client First Capital Research',
      readTimeMinutes: 8,
      tags: ['compounding', 'fundamentals', 'beginner'],
      isPublished: true,
      publishedAt: new Date('2026-01-15'),
      viewCount: 1250,
      createdBy: admin._id,
    },
    {
      title: 'Market Volatility: Your Friend, Not Your Enemy',
      summary: 'Why market downturns are opportunities for disciplined investors.',
      content: 'Market corrections are a natural part of the investment cycle. History shows that investors who stay disciplined during volatility outperform those who panic sell...',
      category: 'Behavioral Finance',
      author: 'Client First Capital Research',
      readTimeMinutes: 6,
      tags: ['volatility', 'behavioral', 'discipline'],
      isPublished: true,
      publishedAt: new Date('2026-02-05'),
      viewCount: 890,
      createdBy: admin._id,
    },
    {
      title: 'Understanding Asset Allocation',
      summary: 'How to distribute investments across different asset classes for optimal returns.',
      content: 'Asset allocation is the process of dividing investments among different categories such as equities, bonds, real estate, and cash...',
      category: 'Strategy',
      author: 'Client First Capital Research',
      readTimeMinutes: 10,
      tags: ['allocation', 'strategy', 'diversification'],
      isPublished: true,
      publishedAt: new Date('2026-02-20'),
      viewCount: 720,
      createdBy: admin._id,
    },
    {
      title: 'UAE Investment Landscape 2026',
      summary: 'Key trends and opportunities in the UAE and GCC investment market.',
      content: 'The UAE continues to position itself as a global investment hub. Key sectors include real estate, technology, renewable energy, and financial services...',
      category: 'Market Insights',
      author: 'Client First Capital Research',
      readTimeMinutes: 12,
      tags: ['UAE', 'GCC', 'market', '2026'],
      isPublished: true,
      publishedAt: new Date('2026-03-01'),
      viewCount: 1580,
      createdBy: admin._id,
    },
    {
      title: 'Risk Profiling: Finding Your Investment Personality',
      summary: 'How to assess your risk tolerance and choose the right investment strategy.',
      content: 'Every investor has a unique risk profile that depends on their age, income, goals, and psychological tolerance for market fluctuations...',
      category: 'Fundamentals',
      author: 'Client First Capital Research',
      readTimeMinutes: 7,
      tags: ['risk', 'profiling', 'beginner'],
      isPublished: true,
      publishedAt: new Date('2026-03-15'),
      viewCount: 650,
      createdBy: admin._id,
    },
  ];

  const result = await EducationContent.insertMany(content);
  console.log(`  ✓ ${result.length} education articles seeded`);
  return result;
}
