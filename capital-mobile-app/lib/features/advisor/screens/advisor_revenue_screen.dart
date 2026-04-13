import 'package:flutter/material.dart';
import 'package:capital_mobile_app/core/theme/app_theme.dart';
import 'package:capital_mobile_app/core/widgets/section_header.dart';

class AdvisorRevenueScreen extends StatelessWidget {
  const AdvisorRevenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Revenue & Incentives'),
        backgroundColor: AppTheme.advisorColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Revenue Summary
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [AppTheme.advisorColor, AppTheme.advisorColor.withValues(alpha: 0.7)]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Revenue (YTD)', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14)),
                  const SizedBox(height: 8),
                  const Text('AED 425,000', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _Stat('This Month', 'AED 85K'),
                      const SizedBox(width: 24),
                      _Stat('Avg/Month', 'AED 71K'),
                      const SizedBox(width: 24),
                      _Stat('Growth', '+15.3%'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Revenue Breakdown
            const SectionHeader(title: 'Revenue Breakdown'),
            const SizedBox(height: 8),
            _RevenueBar('Management Fee', 0.55, 'AED 233K', AppTheme.advisorColor),
            _RevenueBar('Performance Fee', 0.25, 'AED 106K', AppTheme.accentColor),
            _RevenueBar('Advisory Fee', 0.12, 'AED 51K', Colors.orange),
            _RevenueBar('Other', 0.08, 'AED 35K', Colors.grey),
            const SizedBox(height: 24),

            // Incentive Dashboard
            const SectionHeader(title: 'Incentive Dashboard'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.grey.shade200)),
              child: Column(
                children: [
                  _IncentiveRow('Q1 Target', 'AED 250K', 'AED 210K', 84),
                  const Divider(),
                  _IncentiveRow('New Clients Target', '20', '18', 90),
                  const Divider(),
                  _IncentiveRow('AUM Growth', '15%', '12.5%', 83),
                  const Divider(),
                  _IncentiveRow('Client Retention', '95%', '97%', 100),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Performance Ranking
            const SectionHeader(title: 'Performance Ranking'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.secondaryColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppTheme.secondaryColor.withValues(alpha: 0.2)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.emoji_events, color: AppTheme.secondaryColor, size: 32),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rank #3 of 24 Advisors', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text('Top 15% — 2 positions from Gold tier', style: TextStyle(fontSize: 13, color: Colors.grey)),
                      ],
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

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  const _Stat(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 11)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
      ],
    );
  }
}

class _RevenueBar extends StatelessWidget {
  final String label;
  final double percent;
  final String amount;
  final Color color;
  const _RevenueBar(this.label, this.percent, this.amount, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              Text(amount, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: color)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percent,
              backgroundColor: color.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 2),
          Text('${(percent * 100).toInt()}%', style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }
}

class _IncentiveRow extends StatelessWidget {
  final String metric;
  final String target;
  final String achieved;
  final int progress;
  const _IncentiveRow(this.metric, this.target, this.achieved, this.progress);

  @override
  Widget build(BuildContext context) {
    final color = progress >= 100 ? Colors.green : progress >= 80 ? Colors.orange : Colors.red;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(metric, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                Text('Target: $target', style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(achieved, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: color)),
                Text('$progress%', style: TextStyle(fontSize: 11, color: color)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
