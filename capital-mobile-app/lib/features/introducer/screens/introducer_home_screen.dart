import 'package:flutter/material.dart';
import 'package:capital_mobile_app/core/theme/app_theme.dart';
import 'package:capital_mobile_app/core/widgets/stat_card.dart';
import 'package:capital_mobile_app/core/widgets/section_header.dart';
import 'package:capital_mobile_app/features/introducer/screens/introducer_referrals_screen.dart';
import 'package:capital_mobile_app/features/introducer/screens/introducer_commission_screen.dart';
import 'package:capital_mobile_app/features/introducer/screens/introducer_leaderboard_screen.dart';
import 'package:capital_mobile_app/features/introducer/screens/introducer_marketing_screen.dart';

class IntroducerHomeScreen extends StatelessWidget {
  const IntroducerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Introducer Dashboard'),
        backgroundColor: AppTheme.introducerColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.introducerColor,
                    AppTheme.introducerColor.withValues(alpha: 0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome, Ahmed',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Your referral link: cfc.ae/ref/ahmed123',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.copy, size: 16),
                    label: const Text('Copy Referral Link'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppTheme.introducerColor,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Stats Grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.4,
              children: const [
                StatCard(
                  title: 'Total Referrals',
                  value: '48',
                  icon: Icons.people,
                  color: AppTheme.introducerColor,
                  subtitle: '+5 this month',
                ),
                StatCard(
                  title: 'Conversions',
                  value: '32',
                  icon: Icons.check_circle,
                  color: AppTheme.accentColor,
                  subtitle: '66.7%',
                ),
                StatCard(
                  title: 'AUM Generated',
                  value: 'AED 12.5M',
                  icon: Icons.account_balance_wallet,
                  color: AppTheme.primaryColor,
                  subtitle: '+8.2%',
                ),
                StatCard(
                  title: 'Commission Earned',
                  value: 'AED 25K',
                  icon: Icons.payments,
                  color: AppTheme.secondaryColor,
                  subtitle: '+12.5%',
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Quick Actions
            const SectionHeader(title: 'Quick Actions'),
            const SizedBox(height: 8),
            Row(
              children: [
                _QuickActionButton(
                  icon: Icons.people,
                  label: 'Referrals',
                  color: AppTheme.introducerColor,
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const IntroducerReferralsScreen())),
                ),
                const SizedBox(width: 12),
                _QuickActionButton(
                  icon: Icons.payments,
                  label: 'Commission',
                  color: AppTheme.accentColor,
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const IntroducerCommissionScreen())),
                ),
                const SizedBox(width: 12),
                _QuickActionButton(
                  icon: Icons.leaderboard,
                  label: 'Leaderboard',
                  color: AppTheme.secondaryColor,
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const IntroducerLeaderboardScreen())),
                ),
                const SizedBox(width: 12),
                _QuickActionButton(
                  icon: Icons.download,
                  label: 'Marketing',
                  color: AppTheme.primaryColor,
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const IntroducerMarketingScreen())),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Recent Referrals
            const SectionHeader(title: 'Recent Referrals', actionText: 'View All'),
            const SizedBox(height: 8),
            _ReferralItem(
              name: 'Sarah Johnson',
              status: 'Converted',
              date: 'Feb 20, 2026',
              statusColor: AppTheme.accentColor,
            ),
            _ReferralItem(
              name: 'Mohammed Ali',
              status: 'In Progress',
              date: 'Feb 18, 2026',
              statusColor: Colors.orange,
            ),
            _ReferralItem(
              name: 'Priya Sharma',
              status: 'Pending KYC',
              date: 'Feb 15, 2026',
              statusColor: Colors.blue,
            ),
            _ReferralItem(
              name: 'John Smith',
              status: 'New Lead',
              date: 'Feb 12, 2026',
              statusColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.2)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReferralItem extends StatelessWidget {
  final String name;
  final String status;
  final String date;
  final Color statusColor;

  const _ReferralItem({
    required this.name,
    required this.status,
    required this.date,
    required this.statusColor,
  });

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
          CircleAvatar(
            backgroundColor: statusColor.withValues(alpha: 0.1),
            child: Text(
              name[0],
              style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                Text(date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: statusColor),
            ),
          ),
        ],
      ),
    );
  }
}
