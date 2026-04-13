import 'package:flutter/material.dart';
import 'package:capital_mobile_app/core/theme/app_theme.dart';

class CustomerGoalsScreen extends StatelessWidget {
  const CustomerGoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goal Planning'),
        backgroundColor: AppTheme.customerColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Goal Cards
            _GoalCard(
              title: 'Retirement Fund',
              target: 'AED 5,000,000',
              current: 'AED 350,000',
              progress: 0.07,
              targetDate: 'Dec 2035',
              icon: Icons.beach_access,
              color: AppTheme.customerColor,
              status: 'On Track',
              monthlyNeeded: 'AED 28,000/month',
            ),
            const SizedBox(height: 12),
            _GoalCard(
              title: 'Children\'s Education',
              target: 'AED 800,000',
              current: 'AED 120,000',
              progress: 0.15,
              targetDate: 'Sep 2032',
              icon: Icons.school,
              color: Colors.orange,
              status: 'Needs Attention',
              monthlyNeeded: 'AED 8,500/month',
            ),
            const SizedBox(height: 12),
            _GoalCard(
              title: 'Dream Home Down Payment',
              target: 'AED 400,000',
              current: 'AED 180,000',
              progress: 0.45,
              targetDate: 'Jun 2028',
              icon: Icons.home,
              color: AppTheme.accentColor,
              status: 'On Track',
              monthlyNeeded: 'AED 7,300/month',
            ),
            const SizedBox(height: 12),
            _GoalCard(
              title: 'Emergency Fund',
              target: 'AED 100,000',
              current: 'AED 85,000',
              progress: 0.85,
              targetDate: 'Jun 2026',
              icon: Icons.shield,
              color: Colors.purple,
              status: 'Almost Done!',
              monthlyNeeded: 'AED 3,750/month',
            ),
            const SizedBox(height: 24),

            // Compounding Calculator
            const Text('Compounding Calculator', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  _CalcRow('Monthly Investment', 'AED 5,000'),
                  _CalcRow('Expected Return', '12% p.a.'),
                  _CalcRow('Time Horizon', '10 years'),
                  const Divider(height: 24),
                  _CalcRow('Total Invested', 'AED 600,000'),
                  _CalcRow('Expected Returns', 'AED 555,000'),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Wealth', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('AED 1,155,000', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppTheme.accentColor)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Customize Calculation'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppTheme.customerColor,
        icon: const Icon(Icons.add),
        label: const Text('New Goal'),
      ),
    );
  }
}

class _GoalCard extends StatelessWidget {
  final String title;
  final String target;
  final String current;
  final double progress;
  final String targetDate;
  final IconData icon;
  final Color color;
  final String status;
  final String monthlyNeeded;

  const _GoalCard({
    required this.title,
    required this.target,
    required this.current,
    required this.progress,
    required this.targetDate,
    required this.icon,
    required this.color,
    required this.status,
    required this.monthlyNeeded,
  });

  @override
  Widget build(BuildContext context) {
    final isOnTrack = status.contains('On Track') || status.contains('Almost');
    return Container(
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
                width: 42, height: 42,
                decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                    Text('Target by $targetDate', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isOnTrack ? Colors.green.withValues(alpha: 0.1) : Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(status, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: isOnTrack ? Colors.green : Colors.orange)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(current, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color)),
              Text('of $target', style: const TextStyle(fontSize: 13, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: color.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${(progress * 100).toStringAsFixed(0)}% complete', style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text('Suggested: $monthlyNeeded', style: TextStyle(fontSize: 11, color: color)),
            ],
          ),
        ],
      ),
    );
  }
}

class _CalcRow extends StatelessWidget {
  final String label;
  final String value;
  const _CalcRow(this.label, this.value);

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
