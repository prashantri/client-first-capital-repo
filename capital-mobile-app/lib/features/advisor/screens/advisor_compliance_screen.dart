import 'package:flutter/material.dart';
import 'package:capital_mobile_app/core/theme/app_theme.dart';

class AdvisorComplianceScreen extends StatelessWidget {
  const AdvisorComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compliance Checklist'),
        backgroundColor: AppTheme.advisorColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Compliance Score
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  const Text('Compliance Score', style: TextStyle(fontSize: 14, color: Colors.grey)),
                  const SizedBox(height: 12),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          value: 0.92,
                          strokeWidth: 10,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.accentColor),
                        ),
                      ),
                      const Text('92%', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.accentColor)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('Excellent — 1 item pending', style: TextStyle(fontSize: 13, color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Checklist Items
            const Text('Client Onboarding', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _ChecklistItem(title: 'KYC Documents Verification', isCompleted: true),
            _ChecklistItem(title: 'Risk Profile Assessment', isCompleted: true),
            _ChecklistItem(title: 'Suitability Declaration', isCompleted: true),
            _ChecklistItem(title: 'Investment Agreement Signed', isCompleted: true),
            const SizedBox(height: 20),

            const Text('Ongoing Compliance', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _ChecklistItem(title: 'Annual KYC Review', isCompleted: true),
            _ChecklistItem(title: 'Portfolio Suitability Check', isCompleted: true),
            _ChecklistItem(title: 'Meeting Notes Documentation', isCompleted: false),
            _ChecklistItem(title: 'Conflict of Interest Disclosure', isCompleted: true),
            const SizedBox(height: 20),

            const Text('Regulatory Requirements', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _ChecklistItem(title: 'AML/CTF Training (Annual)', isCompleted: true),
            _ChecklistItem(title: 'DFSA Continuing Education', isCompleted: true),
            _ChecklistItem(title: 'Fit & Proper Declaration', isCompleted: true),
            _ChecklistItem(title: 'Code of Conduct Acknowledgment', isCompleted: true),
          ],
        ),
      ),
    );
  }
}

class _ChecklistItem extends StatelessWidget {
  final String title;
  final bool isCompleted;
  const _ChecklistItem({required this.title, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isCompleted ? Colors.green.withValues(alpha: 0.04) : Colors.orange.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCompleted ? Colors.green.withValues(alpha: 0.2) : Colors.orange.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isCompleted ? Colors.green : Colors.orange,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isCompleted ? Colors.grey.shade700 : Colors.orange.shade800,
                decoration: isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
          if (!isCompleted)
            TextButton(
              onPressed: () {},
              child: const Text('Complete', style: TextStyle(fontSize: 12)),
            ),
        ],
      ),
    );
  }
}
