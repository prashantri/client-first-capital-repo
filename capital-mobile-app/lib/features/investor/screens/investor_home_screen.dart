import 'package:flutter/material.dart';
import 'package:capital_mobile_app/core/theme/app_theme.dart';
import 'package:capital_mobile_app/core/widgets/stat_card.dart';
import 'package:capital_mobile_app/core/widgets/section_header.dart';

class InvestorHomeScreen extends StatelessWidget {
  const InvestorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shareholder Portal'),
        backgroundColor: AppTheme.investorColor,
        actions: [
          IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.person_outline), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shareholding Summary
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.investorColor, AppTheme.investorColor.withValues(alpha: 0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Shareholder', style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.8))),
                  const SizedBox(height: 4),
                  const Text('Khalid Al Maktoum', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _ShareStat('Shares Held', '50,000'),
                      const SizedBox(width: 24),
                      _ShareStat('Ownership', '5.0%'),
                      const SizedBox(width: 24),
                      _ShareStat('Share Class', 'Class A'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Member since January 2024', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Valuation Stats
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.4,
              children: const [
                StatCard(title: 'Company Valuation', value: 'AED 50M', icon: Icons.business, color: AppTheme.investorColor, subtitle: '+22% YoY'),
                StatCard(title: 'Your Share Value', value: 'AED 2.5M', icon: Icons.account_balance_wallet, color: AppTheme.accentColor, subtitle: '+22%'),
                StatCard(title: 'Total AUM', value: 'AED 320M', icon: Icons.trending_up, color: AppTheme.primaryColor, subtitle: '+35% YoY'),
                StatCard(title: 'Active Clients', value: '2,450', icon: Icons.people, color: AppTheme.secondaryColor, subtitle: '+480 this year'),
              ],
            ),
            const SizedBox(height: 24),

            // Company Valuation Timeline
            const SectionHeader(title: 'Valuation History'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: const Column(
                children: [
                  _ValuationRow('Q4 2025', 'AED 50M', '+8.7%', true),
                  Divider(),
                  _ValuationRow('Q3 2025', 'AED 46M', '+10.2%', false),
                  Divider(),
                  _ValuationRow('Q2 2025', 'AED 41.7M', '+12.5%', false),
                  Divider(),
                  _ValuationRow('Q1 2025', 'AED 37.1M', '+15.3%', false),
                  Divider(),
                  _ValuationRow('Q4 2024', 'AED 32.2M', '—', false),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Reports & Documents
            const SectionHeader(title: 'Reports & Documents'),
            const SizedBox(height: 8),
            _DocumentItem(title: 'Q4 2025 Quarterly Report', type: 'PDF', date: 'Jan 15, 2026'),
            _DocumentItem(title: 'Annual Report 2025', type: 'PDF', date: 'Jan 30, 2026'),
            _DocumentItem(title: 'Board Meeting Minutes — Dec 2025', type: 'PDF', date: 'Dec 20, 2025'),
            _DocumentItem(title: 'Q3 2025 Quarterly Report', type: 'PDF', date: 'Oct 15, 2025'),
            const SizedBox(height: 24),

            // Board Updates & Announcements
            const SectionHeader(title: 'Board Updates & Announcements'),
            const SizedBox(height: 8),
            _AnnouncementCard(
              title: 'Annual General Meeting 2026',
              description: 'AGM scheduled for March 15, 2026, at Dubai Financial Centre. All shareholders are invited to attend.',
              date: 'Feb 20, 2026',
              type: 'AGM',
              color: AppTheme.investorColor,
            ),
            _AnnouncementCard(
              title: 'New Office Expansion — Abu Dhabi',
              description: 'Client First Capital is expanding operations with a new office in Abu Dhabi, targeting Q2 2026 opening.',
              date: 'Feb 10, 2026',
              type: 'Update',
              color: AppTheme.accentColor,
            ),
            _AnnouncementCard(
              title: 'Strategic Partnership Announcement',
              description: 'Partnership with Global Investment Bank for enhanced product offerings and research capabilities.',
              date: 'Jan 28, 2026',
              type: 'News',
              color: AppTheme.primaryColor,
            ),
            const SizedBox(height: 24),

            // Exit Mechanism
            const SectionHeader(title: 'Exit Mechanism'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.info_outline, color: AppTheme.investorColor, size: 20),
                      const SizedBox(width: 8),
                      const Text('Share Transfer & Exit', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _ExitRow('Lock-in Period', '2 years (completed)'),
                  _ExitRow('Current NAV per Share', 'AED 50.00'),
                  _ExitRow('Next Exit Window', 'April 1 – April 30, 2026'),
                  _ExitRow('Notice Period', '30 days'),
                  _ExitRow('Transfer Fee', '0.5% of share value'),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.info_outline, size: 16),
                      label: const Text('View Full Exit Policy'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShareStat extends StatelessWidget {
  final String label;
  final String value;
  const _ShareStat(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 11)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }
}

class _ValuationRow extends StatelessWidget {
  final String period;
  final String value;
  final String change;
  final bool isCurrent;
  const _ValuationRow(this.period, this.value, this.change, this.isCurrent);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 8, height: 8,
            decoration: BoxDecoration(
              color: isCurrent ? AppTheme.investorColor : Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Text(period, style: TextStyle(fontSize: 14, fontWeight: isCurrent ? FontWeight.w600 : FontWeight.normal)),
          const Spacer(),
          Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: isCurrent ? AppTheme.investorColor : Colors.black87)),
          const SizedBox(width: 12),
          SizedBox(
            width: 60,
            child: Text(change, style: TextStyle(fontSize: 12, color: change.startsWith('+') ? Colors.green : Colors.grey), textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }
}

class _DocumentItem extends StatelessWidget {
  final String title;
  final String type;
  final String date;
  const _DocumentItem({required this.title, required this.type, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 42, height: 42,
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.picture_as_pdf, color: Colors.red.shade700, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                Text(date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          IconButton(icon: const Icon(Icons.download, color: AppTheme.investorColor), onPressed: () {}),
        ],
      ),
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String type;
  final Color color;
  const _AnnouncementCard({required this.title, required this.description, required this.date, required this.type, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
                child: Text(type, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color)),
              ),
              const Spacer(),
              Text(date, style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
          const SizedBox(height: 4),
          Text(description, style: const TextStyle(fontSize: 13, color: Colors.grey, height: 1.4)),
        ],
      ),
    );
  }
}

class _ExitRow extends StatelessWidget {
  final String label;
  final String value;
  const _ExitRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
