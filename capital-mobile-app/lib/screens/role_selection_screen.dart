import 'package:flutter/material.dart';
import 'package:capital_mobile_app/core/theme/app_theme.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              // Header
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.account_balance,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Client First Capital',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Select your role to continue',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 40),
              // Role Cards
              Expanded(
                child: ListView(
                  children: [
                    _RoleCard(
                      title: 'Introducer',
                      subtitle: 'Client Referral Partner',
                      description: 'Refer clients, track leads, and earn commissions on AUM generated.',
                      icon: Icons.people_outline,
                      color: AppTheme.introducerColor,
                      onTap: () => Navigator.pushNamed(context, '/introducer'),
                    ),
                    const SizedBox(height: 16),
                    _RoleCard(
                      title: 'Advisor',
                      subtitle: 'Relationship & Revenue Manager',
                      description: 'Manage clients, portfolios, and revenue with AI-powered insights.',
                      icon: Icons.analytics_outlined,
                      color: AppTheme.advisorColor,
                      onTap: () => Navigator.pushNamed(context, '/advisor'),
                    ),
                    const SizedBox(height: 16),
                    _RoleCard(
                      title: 'Customer',
                      subtitle: 'Investor Journey',
                      description: 'Start investing, track portfolios, and build wealth with discipline.',
                      icon: Icons.trending_up,
                      color: AppTheme.customerColor,
                      onTap: () => Navigator.pushNamed(context, '/customer'),
                    ),
                    const SizedBox(height: 16),
                    _RoleCard(
                      title: 'Investor',
                      subtitle: 'Shareholder / Business Partner',
                      description: 'View shareholding, company valuation, and business growth.',
                      icon: Icons.business_center_outlined,
                      color: AppTheme.investorColor,
                      onTap: () => Navigator.pushNamed(context, '/investor'),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      shadowColor: color.withValues(alpha: 0.2),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: color.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
