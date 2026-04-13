import { Portfolio, RiskLevel, User, UserRole } from '../models';

export async function seedPortfolios() {
  console.log('Seeding portfolios...');

  const customers = await User.find({ role: UserRole.CUSTOMER, status: 'active' });
  const advisors = await User.find({ role: UserRole.ADVISOR });

  if (!customers.length || !advisors.length) {
    console.log('  ⚠ Skipping portfolios - no customers or advisors');
    return [];
  }

  const portfolios = [
    {
      customerId: customers[0]._id, // Ahmed
      advisorId: advisors[0]._id,
      portfolioName: 'Growth Portfolio',
      totalValue: 350000,
      investedAmount: 311111,
      currency: 'AED',
      riskLevel: RiskLevel.MODERATE,
      allocation: { equities: 50, bonds: 25, realEstate: 15, cash: 10 },
      holdings: [
        { symbol: 'VOO', name: 'Vanguard S&P 500 ETF', assetClass: 'Equities', quantity: 120, avgBuyPrice: 380, currentPrice: 420, marketValue: 50400, gainLoss: 4800, gainLossPercent: 10.5, currency: 'USD' },
        { symbol: 'EEM', name: 'iShares MSCI Emerging Markets', assetClass: 'Equities', quantity: 500, avgBuyPrice: 38, currentPrice: 42, marketValue: 21000, gainLoss: 2000, gainLossPercent: 10.5, currency: 'USD' },
        { symbol: 'BND', name: 'Vanguard Total Bond Market', assetClass: 'Bonds', quantity: 300, avgBuyPrice: 72, currentPrice: 74, marketValue: 22200, gainLoss: 600, gainLossPercent: 2.8, currency: 'USD' },
        { symbol: 'UAEBCF', name: 'UAE Bond Corporate Fund', assetClass: 'Bonds', quantity: 1000, avgBuyPrice: 50, currentPrice: 52, marketValue: 52000, gainLoss: 2000, gainLossPercent: 4.0, currency: 'AED' },
        { symbol: 'REITS', name: 'Emirates REIT Fund', assetClass: 'Real Estate', quantity: 800, avgBuyPrice: 55, currentPrice: 60, marketValue: 48000, gainLoss: 4000, gainLossPercent: 9.1, currency: 'AED' },
      ],
      ytdReturn: 12.5,
      absoluteGain: 38889,
      disciplineScore: 85,
      inceptionDate: new Date('2024-06-01'),
      lastRebalancedAt: new Date('2026-01-15'),
    },
    {
      customerId: customers[1]._id, // Priya
      advisorId: advisors[1]._id,
      portfolioName: 'Conservative Income',
      totalValue: 180000,
      investedAmount: 165000,
      currency: 'AED',
      riskLevel: RiskLevel.CONSERVATIVE,
      allocation: { equities: 20, bonds: 50, realEstate: 20, cash: 10 },
      holdings: [
        { symbol: 'AGG', name: 'iShares Core US Aggregate Bond', assetClass: 'Bonds', quantity: 400, avgBuyPrice: 98, currentPrice: 101, marketValue: 40400, gainLoss: 1200, gainLossPercent: 3.1, currency: 'USD' },
        { symbol: 'VNQ', name: 'Vanguard Real Estate ETF', assetClass: 'Real Estate', quantity: 200, avgBuyPrice: 82, currentPrice: 88, marketValue: 17600, gainLoss: 1200, gainLossPercent: 7.3, currency: 'USD' },
        { symbol: 'SCHD', name: 'Schwab US Dividend Equity', assetClass: 'Equities', quantity: 150, avgBuyPrice: 72, currentPrice: 78, marketValue: 11700, gainLoss: 900, gainLossPercent: 8.3, currency: 'USD' },
      ],
      ytdReturn: 6.2,
      absoluteGain: 15000,
      disciplineScore: 92,
      inceptionDate: new Date('2024-09-01'),
    },
    {
      customerId: customers[2]._id, // David
      advisorId: advisors[0]._id,
      portfolioName: 'Aggressive Growth',
      totalValue: 720000,
      investedAmount: 600000,
      currency: 'AED',
      riskLevel: RiskLevel.AGGRESSIVE,
      allocation: { equities: 70, bonds: 10, realEstate: 10, cash: 5, alternatives: 5 },
      holdings: [
        { symbol: 'QQQ', name: 'Invesco QQQ Trust', assetClass: 'Equities', quantity: 300, avgBuyPrice: 380, currentPrice: 445, marketValue: 133500, gainLoss: 19500, gainLossPercent: 17.1, currency: 'USD' },
        { symbol: 'ARKK', name: 'ARK Innovation ETF', assetClass: 'Equities', quantity: 500, avgBuyPrice: 45, currentPrice: 52, marketValue: 26000, gainLoss: 3500, gainLossPercent: 15.6, currency: 'USD' },
        { symbol: 'VOO', name: 'Vanguard S&P 500 ETF', assetClass: 'Equities', quantity: 250, avgBuyPrice: 390, currentPrice: 420, marketValue: 105000, gainLoss: 7500, gainLossPercent: 7.7, currency: 'USD' },
      ],
      ytdReturn: 18.3,
      absoluteGain: 120000,
      disciplineScore: 72,
      inceptionDate: new Date('2024-03-01'),
      lastRebalancedAt: new Date('2026-02-01'),
    },
    {
      customerId: customers[3]._id, // Chen Wei
      advisorId: advisors[0]._id,
      portfolioName: 'Balanced Wealth',
      totalValue: 1050000,
      investedAmount: 950000,
      currency: 'AED',
      riskLevel: RiskLevel.MODERATE,
      allocation: { equities: 45, bonds: 30, realEstate: 15, cash: 10 },
      holdings: [
        { symbol: 'VT', name: 'Vanguard Total World Stock', assetClass: 'Equities', quantity: 600, avgBuyPrice: 95, currentPrice: 108, marketValue: 64800, gainLoss: 7800, gainLossPercent: 13.7, currency: 'USD' },
        { symbol: 'BNDX', name: 'Vanguard Intl Bond ETF', assetClass: 'Bonds', quantity: 800, avgBuyPrice: 48, currentPrice: 50, marketValue: 40000, gainLoss: 1600, gainLossPercent: 4.2, currency: 'USD' },
      ],
      ytdReturn: 10.5,
      absoluteGain: 100000,
      disciplineScore: 88,
      inceptionDate: new Date('2024-01-15'),
    },
  ];

  const result = await Portfolio.insertMany(portfolios);
  console.log(`  ✓ ${result.length} portfolios seeded`);
  return result;
}
