import 'package:flutter/material.dart';
import 'package:capital_mobile_app/core/theme/app_theme.dart';
import 'package:capital_mobile_app/core/widgets/stat_card.dart';
import 'package:capital_mobile_app/core/widgets/section_header.dart';
import 'package:capital_mobile_app/features/advisor/screens/advisor_clients_screen.dart';
import 'package:capital_mobile_app/features/advisor/screens/advisor_revenue_screen.dart';
import 'package:capital_mobile_app/features/advisor/screens/advisor_compliance_screen.dart';
import 'package:capital_mobile_app/features/advisor/screens/advisor_ai_assistant_screen.dart';

class AdvisorHomeScreen extends StatelessWidget {
  const AdvisorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advisor Dashboard'),
        backgroundColor: AppTheme.advisorColor,
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
            // Welcome Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.advisorColor, AppTheme.advisorColor.withValues(alpha: 0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Good Morning, Fatima', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 4),
                  Text('3 meetings today • 2 pending follow-ups', style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.8))),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _MiniStat('Clients', '156'),
                      const SizedBox(width: 20),
                      _MiniStat('AUM Managed', 'AED 45M'),
                      const SizedBox(width: 20),
                      _MiniStat('Rank', '#3'),
                    ],
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
                StatCard(title: 'Active Clients', value: '156', icon: Icons.people, color: AppTheme.advisorColor, subtitle: '+8 this month'),
                StatCard(title: 'Revenue (MTD)', value: 'AED 85K', icon: Icons.trending_up, color: AppTheme.accentColor, subtitle: '+15.3%'),
                StatCard(title: 'New Leads', value: '12', icon: Icons.person_add, color: Colors.orange, subtitle: '5 uncontacted'),
                StatCard(title: 'Risk Alerts', value: '3', icon: Icons.warning_amber, color: Colors.red, subtitle: 'Needs attention'),
              ],
            ),
            const SizedBox(height: 24),

            // Quick Actions
            const SectionHeader(title: 'Quick Actions'),
            const SizedBox(height: 8),
            Row(
              children: [
                _QuickAction(icon: Icons.people, label: 'Clients', color: AppTheme.advisorColor,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdvisorClientsScreen()))),
                const SizedBox(width: 12),
                _QuickAction(icon: Icons.payments, label: 'Revenue', color: AppTheme.accentColor,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdvisorRevenueScreen()))),
                const SizedBox(width: 12),
                _QuickAction(icon: Icons.checklist, label: 'Compliance', color: Colors.orange,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdvisorComplianceScreen()))),
                const SizedBox(width: 12),
                _QuickAction(icon: Icons.smart_toy, label: 'AI Assistant', color: AppTheme.primaryColor,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdvisorAIAssistantScreen()))),
              ],
            ),
            const SizedBox(height: 24),

            // Today's Schedule
            const SectionHeader(title: "Today's Schedule", actionText: 'Full Calendar'),
            const SizedBox(height: 8),
            _ScheduleItem(time: '10:00 AM', client: 'Sarah Johnson', type: 'Portfolio Review', status: 'Confirmed'),
            _ScheduleItem(time: '11:30 AM', client: 'Mohammed Ali', type: 'Risk Profiling', status: 'Confirmed'),
            _ScheduleItem(time: '2:00 PM', client: 'Emily Chen', type: 'Onboarding', status: 'Pending'),
            const SizedBox(height: 24),

            // Risk Mismatch Alerts
            const SectionHeader(title: 'Risk Mismatch Alerts'),
            const SizedBox(height: 8),
            _AlertCard(
              client: 'James Wilson',
              message: 'Portfolio risk level (Aggressive) exceeds client risk profile (Moderate)',
              severity: 'High',
            ),
            _AlertCard(
              client: 'Aisha Khan',
              message: 'Concentrated position in tech sector (72%) — diversification recommended',
              severity: 'Medium',
            ),
            _AlertCard(
              client: 'Robert Green',
              message: 'Portfolio allocation drift >5% from target — rebalancing suggested',
              severity: 'Low',
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;
  const _MiniStat(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 11)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _QuickAction({required this.icon, required this.label, required this.color, required this.onTap});

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

class _ScheduleItem extends StatelessWidget {
  final String time;
  final String client;
  final String type;
  final String status;
  const _ScheduleItem({required this.time, required this.client, required this.type, required this.status});

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
            width: 52,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.advisorColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(time, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.advisorColor), textAlign: TextAlign.center),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(client, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                Text(type, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: status == 'Confirmed' ? Colors.green.withValues(alpha: 0.1) : Colors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: status == 'Confirmed' ? Colors.green : Colors.orange),
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  final String client;
  final String message;
  final String severity;
  const _AlertCard({required this.client, required this.message, required this.severity});

  Color get _severityColor {
    switch (severity) {
      case 'High': return Colors.red;
      case 'Medium': return Colors.orange;
      default: return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _severityColor.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _severityColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, color: _severityColor, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(client, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: _severityColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
                      child: Text(severity, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _severityColor)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(message, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
