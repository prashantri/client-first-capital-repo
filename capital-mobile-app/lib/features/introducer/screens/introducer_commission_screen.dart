import 'package:flutter/material.dart';
import 'package:capital_mobile_app/core/theme/app_theme.dart';
import 'package:capital_mobile_app/core/widgets/section_header.dart';

class IntroducerCommissionScreen extends StatelessWidget {
  const IntroducerCommissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Commission & Payouts'),
        backgroundColor: AppTheme.introducerColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Earnings Summary
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.introducerColor, AppTheme.introducerColor.withValues(alpha: 0.7)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Earnings', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14)),
                  const SizedBox(height: 8),
                  const Text('AED 125,000', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _EarningStat('This Month', 'AED 12,500'),
                      const SizedBox(width: 24),
                      _EarningStat('Pending', 'AED 3,200'),
                      const SizedBox(width: 24),
                      _EarningStat('Last Payout', 'AED 8,000'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Commission Breakdown
            const SectionHeader(title: 'Commission Breakdown'),
            const SizedBox(height: 8),
            _CommissionRow('AUM-based Commission', 'AED 85,000', '0.5% of AUM'),
            _CommissionRow('Referral Bonus', 'AED 25,000', 'AED 500 per conversion'),
            _CommissionRow('Performance Bonus', 'AED 15,000', 'Quarterly incentive'),
            const SizedBox(height: 24),

            // Payout History
            const SectionHeader(title: 'Payout History', actionText: 'Download'),
            const SizedBox(height: 8),
            ..._buildPayoutHistory(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPayoutHistory() {
    final payouts = [
      ('Feb 2026', 'AED 8,000', 'Completed', 'Feb 15'),
      ('Jan 2026', 'AED 10,500', 'Completed', 'Jan 15'),
      ('Dec 2025', 'AED 7,200', 'Completed', 'Dec 15'),
      ('Nov 2025', 'AED 9,800', 'Completed', 'Nov 15'),
      ('Oct 2025', 'AED 11,000', 'Completed', 'Oct 15'),
    ];

    return payouts.map((item) {
      final (month, amount, status, date) = item;
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
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppTheme.accentColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.receipt_long, color: AppTheme.accentColor, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(month, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  Text('Paid on $date', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppTheme.accentColor)),
                Text(status, style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ],
        ),
      );
    }).toList();
  }
}

class _EarningStat extends StatelessWidget {
  final String label;
  final String value;

  const _EarningStat(this.label, this.value);

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

class _CommissionRow extends StatelessWidget {
  final String title;
  final String amount;
  final String description;

  const _CommissionRow(this.title, this.amount, this.description);

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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                Text(description, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppTheme.introducerColor)),
        ],
      ),
    );
  }
}
