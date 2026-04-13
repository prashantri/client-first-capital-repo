import 'package:flutter/material.dart';
import 'package:capital_mobile_app/core/theme/app_theme.dart';

class AdvisorClientsScreen extends StatelessWidget {
  const AdvisorClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Management'),
        backgroundColor: AppTheme.advisorColor,
        actions: [
          IconButton(icon: const Icon(Icons.sort), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Search & Filters
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search clients...',
                    prefixIcon: const Icon(Icons.search, size: 20),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _FilterChip(label: 'All (156)', isSelected: true),
                      _FilterChip(label: 'Active (140)'),
                      _FilterChip(label: 'High Risk (12)'),
                      _FilterChip(label: 'Pending KYC (4)'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Client List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                _ClientCard(
                  name: 'Sarah Johnson',
                  portfolio: 'AED 2.5M',
                  riskProfile: 'Moderate',
                  lastMeeting: 'Feb 20, 2026',
                  performance: '+8.5%',
                  riskColor: Colors.orange,
                ),
                _ClientCard(
                  name: 'Mohammed Ali',
                  portfolio: 'AED 1.8M',
                  riskProfile: 'Conservative',
                  lastMeeting: 'Feb 18, 2026',
                  performance: '+5.2%',
                  riskColor: Colors.green,
                ),
                _ClientCard(
                  name: 'Emily Chen',
                  portfolio: 'AED 5.2M',
                  riskProfile: 'Aggressive',
                  lastMeeting: 'Feb 15, 2026',
                  performance: '+14.8%',
                  riskColor: Colors.red,
                ),
                _ClientCard(
                  name: 'James Wilson',
                  portfolio: 'AED 3.1M',
                  riskProfile: 'Moderate',
                  lastMeeting: 'Feb 12, 2026',
                  performance: '+7.1%',
                  riskColor: Colors.orange,
                ),
                _ClientCard(
                  name: 'Aisha Khan',
                  portfolio: 'AED 890K',
                  riskProfile: 'Conservative',
                  lastMeeting: 'Feb 10, 2026',
                  performance: '+4.3%',
                  riskColor: Colors.green,
                ),
                _ClientCard(
                  name: 'Robert Green',
                  portfolio: 'AED 4.5M',
                  riskProfile: 'Aggressive',
                  lastMeeting: 'Feb 8, 2026',
                  performance: '+12.2%',
                  riskColor: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppTheme.advisorColor,
        icon: const Icon(Icons.person_add),
        label: const Text('Add Client'),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  const _FilterChip({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(label, style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : AppTheme.advisorColor)),
        backgroundColor: isSelected ? AppTheme.advisorColor : AppTheme.advisorColor.withValues(alpha: 0.1),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 4),
      ),
    );
  }
}

class _ClientCard extends StatelessWidget {
  final String name;
  final String portfolio;
  final String riskProfile;
  final String lastMeeting;
  final String performance;
  final Color riskColor;

  const _ClientCard({
    required this.name,
    required this.portfolio,
    required this.riskProfile,
    required this.lastMeeting,
    required this.performance,
    required this.riskColor,
  });

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
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppTheme.advisorColor.withValues(alpha: 0.1),
                child: Text(name[0], style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.advisorColor)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                    Text('Last meeting: $lastMeeting', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(portfolio, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppTheme.advisorColor)),
                  Text(performance, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.green)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: riskColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                child: Text(riskProfile, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: riskColor)),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.calendar_today, size: 14),
                label: const Text('Schedule', style: TextStyle(fontSize: 12)),
                style: TextButton.styleFrom(foregroundColor: AppTheme.advisorColor),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.assessment, size: 14),
                label: const Text('Portfolio', style: TextStyle(fontSize: 12)),
                style: TextButton.styleFrom(foregroundColor: AppTheme.advisorColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
