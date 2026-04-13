import 'package:flutter/material.dart';
import 'package:capital_mobile_app/core/theme/app_theme.dart';
import 'package:capital_mobile_app/core/widgets/section_header.dart';

class IntroducerReferralsScreen extends StatelessWidget {
  const IntroducerReferralsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Referrals'),
        backgroundColor: AppTheme.introducerColor,
      ),
      body: Column(
        children: [
          // Search & Filter Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search referrals...',
                      prefixIcon: const Icon(Icons.search, size: 20),
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.introducerColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.filter_list, color: AppTheme.introducerColor),
                ),
              ],
            ),
          ),
          // Status Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _StatusChip(label: 'All (48)', isSelected: true),
                _StatusChip(label: 'Converted (32)'),
                _StatusChip(label: 'In Progress (8)'),
                _StatusChip(label: 'Pending (5)'),
                _StatusChip(label: 'New (3)'),
              ],
            ),
          ),
          // Referral List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SectionHeader(title: 'February 2026'),
                ..._buildReferrals([
                  ('Sarah Johnson', 'Converted', 'AUM: AED 500K', 'Feb 20', Colors.green),
                  ('Mohammed Ali', 'In Progress', 'Meeting scheduled', 'Feb 18', Colors.orange),
                  ('Priya Sharma', 'Pending KYC', 'Docs uploaded', 'Feb 15', Colors.blue),
                  ('John Smith', 'New Lead', 'Awaiting contact', 'Feb 12', Colors.grey),
                ]),
                const SizedBox(height: 16),
                const SectionHeader(title: 'January 2026'),
                ..._buildReferrals([
                  ('Emily Chen', 'Converted', 'AUM: AED 1.2M', 'Jan 28', Colors.green),
                  ('Khalid Ibrahim', 'Converted', 'AUM: AED 350K', 'Jan 22', Colors.green),
                  ('Lisa Park', 'Converted', 'AUM: AED 780K', 'Jan 15', Colors.green),
                  ('David Brown', 'In Progress', 'Follow-up pending', 'Jan 10', Colors.orange),
                  ('Fatima Hassan', 'Converted', 'AUM: AED 200K', 'Jan 5', Colors.green),
                ]),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppTheme.introducerColor,
        icon: const Icon(Icons.person_add),
        label: const Text('New Referral'),
      ),
    );
  }

  List<Widget> _buildReferrals(List<(String, String, String, String, Color)> data) {
    return data.map((item) {
      final (name, status, info, date, color) = item;
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
              backgroundColor: color.withValues(alpha: 0.1),
              child: Text(name[0], style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(info, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  Text(date, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                status,
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _StatusChip({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? Colors.white : AppTheme.introducerColor,
          ),
        ),
        backgroundColor: isSelected ? AppTheme.introducerColor : AppTheme.introducerColor.withValues(alpha: 0.1),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 4),
      ),
    );
  }
}
