import 'package:flutter/material.dart';
import 'package:capital_mobile_app/core/theme/app_theme.dart';
import 'package:capital_mobile_app/core/widgets/section_header.dart';
import 'package:capital_mobile_app/features/customer/screens/customer_portfolio_screen.dart';
import 'package:capital_mobile_app/features/customer/screens/customer_education_screen.dart';
import 'package:capital_mobile_app/features/customer/screens/customer_goals_screen.dart';
import 'package:capital_mobile_app/features/customer/screens/customer_appointment_screen.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wealth Dashboard'),
        backgroundColor: AppTheme.customerColor,
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
            // Portfolio Summary Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.customerColor, AppTheme.customerColor.withValues(alpha: 0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome, Priya', style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.8))),
                  const SizedBox(height: 8),
                  const Text('AED 350,000', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
                        child: const Row(
                          children: [
                            Icon(Icons.arrow_upward, color: Colors.greenAccent, size: 14),
                            SizedBox(width: 4),
                            Text('+12.5% (YTD)', style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.w600, fontSize: 13)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text('AED +38,889', style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Mini portfolio allocation
                  Row(
                    children: [
                      _AllocationChip('Equities', '50%', Colors.blue.shade200),
                      const SizedBox(width: 8),
                      _AllocationChip('Bonds', '25%', Colors.green.shade200),
                      const SizedBox(width: 8),
                      _AllocationChip('Real Estate', '15%', Colors.orange.shade200),
                      const SizedBox(width: 8),
                      _AllocationChip('Cash', '10%', Colors.grey.shade300),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Investor Discipline Score
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.accentColor.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppTheme.accentColor.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 56,
                        height: 56,
                        child: CircularProgressIndicator(
                          value: 0.85,
                          strokeWidth: 6,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.accentColor),
                        ),
                      ),
                      const Text('85', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.accentColor)),
                    ],
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Investor Discipline Score', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                        Text('Stay consistent with your investment plan', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                  const Icon(Icons.info_outline, color: Colors.grey, size: 20),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Quick Actions
            Row(
              children: [
                _ActionButton(icon: Icons.pie_chart, label: 'Portfolio', color: AppTheme.customerColor,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerPortfolioScreen()))),
                const SizedBox(width: 12),
                _ActionButton(icon: Icons.flag, label: 'Goals', color: AppTheme.accentColor,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerGoalsScreen()))),
                const SizedBox(width: 12),
                _ActionButton(icon: Icons.school, label: 'Learn', color: AppTheme.secondaryColor,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerEducationScreen()))),
                const SizedBox(width: 12),
                _ActionButton(icon: Icons.calendar_today, label: 'Book', color: Colors.orange,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerAppointmentScreen()))),
              ],
            ),
            const SizedBox(height: 24),

            // Market Panic Alert (Behavioral Finance)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.psychology, color: Colors.amber, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Market Insight', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        const SizedBox(height: 4),
                        Text(
                          'Markets dipped 2.3% this week. Historically, staying invested during corrections has yielded 15% average returns over the next 12 months. Stay the course!',
                          style: TextStyle(fontSize: 13, color: Colors.grey.shade700, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Compounding Calculator Preview
            const SectionHeader(title: 'Wealth Projection'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _ProjectionItem('Current', 'AED 350K', AppTheme.customerColor),
                      const Icon(Icons.arrow_forward, color: Colors.grey, size: 16),
                      _ProjectionItem('5 Years', 'AED 620K', Colors.orange),
                      const Icon(Icons.arrow_forward, color: Colors.grey, size: 16),
                      _ProjectionItem('10 Years', 'AED 1.1M', AppTheme.accentColor),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text('*Based on 12% annualized return with monthly contributions of AED 5,000',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade500, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Weekly Wealth Insights
            const SectionHeader(title: 'Weekly Insights'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Icon(Icons.format_quote, color: AppTheme.secondaryColor, size: 28),
                  const SizedBox(height: 8),
                  const Text(
                    '"Compound interest is the eighth wonder of the world."',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 15, fontStyle: FontStyle.italic, height: 1.5),
                  ),
                  const SizedBox(height: 8),
                  Text('— Albert Einstein', style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AllocationChip extends StatelessWidget {
  final String label;
  final String percent;
  final Color color;
  const _AllocationChip(this.label, this.percent, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(6)),
      child: Text('$label $percent', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white)),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ActionButton({required this.icon, required this.label, required this.color, required this.onTap});

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
              Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectionItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _ProjectionItem(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: color)),
      ],
    );
  }
}
