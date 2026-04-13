import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:capital_mobile_app/core/theme/app_theme.dart';

class IntroducerDashboardScreen extends StatelessWidget {
  const IntroducerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: Column(
        children: [
          _buildAppBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    _buildGreeting(),
                    const SizedBox(height: 24),
                    _buildSummaryCards(),
                    const SizedBox(height: 32),
                    _buildRecentActivity(),
                    const SizedBox(height: 24),
                    _buildPortalIndicator(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFAB(context),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.only(top: 48, left: 24, right: 24, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(204),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 4,
          ),
        ],
        border: Border(
          bottom: BorderSide(color: const Color(0xFFF5F5F4)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.menu, color: const Color(0xFF1B3012), size: 24),
              const SizedBox(width: 16),
              Image.asset('assets/images/logo.png', width: 22, height: 22),
              const SizedBox(width: 8),
              Text(
                'Client First Capital',
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1B3012),
                  letterSpacing: -0.8,
                ),
              ),
            ],
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFF5F5F4),
              border: Border.all(color: const Color(0xFFE5E5E5), width: 2),
            ),
            child:
                const Icon(Icons.person, size: 20, color: Color(0xFF78716C)),
          ),
        ],
      ),
    );
  }

  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, Alexander',
          style: GoogleFonts.manrope(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF1B3012),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Welcome back to your Institutional Portal. Your network overview.',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCards() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildStatCard(
              icon: Icons.group,
              iconColor: const Color(0xFF3D6623),
              label: 'TOTAL REFERRALS',
              value: '124',
            )),
            const SizedBox(width: 16),
            Expanded(child: _buildStatCard(
              icon: Icons.verified,
              iconColor: const Color(0xFF2D4C1B),
              label: 'APPROVED LEADS',
              value: '85',
              badge: 'GROWTH',
              badgeColor: const Color(0xFFE8F5E9),
              badgeTextColor: const Color(0xFF2D4C1B),
            )),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildStatCard(
              icon: Icons.pending,
              iconColor: const Color(0xFFD4AF37),
              label: 'PENDING LEADS',
              value: '22',
              badge: 'PENDING',
              badgeColor: const Color(0xFFF1C40F).withAlpha(26),
              badgeTextColor: const Color(0xFF917500),
            )),
            const SizedBox(width: 16),
            Expanded(child: _buildEarningsCard()),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    String? badge,
    Color? badgeColor,
    Color? badgeTextColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF5F5F4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: iconColor, size: 24),
              if (badge != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    badge,
                    style: GoogleFonts.manrope(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      color: badgeTextColor,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              color: AppTheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.manrope(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1B3012),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1B3012),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withAlpha(51),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.payments, color: const Color(0xFFF1C40F), size: 24),
          const SizedBox(height: 16),
          Text(
            'TOTAL EARNINGS',
            style: GoogleFonts.manrope(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              color: const Color(0xFFA5D6A7).withAlpha(204),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '₹45,000',
            style: GoogleFonts.manrope(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Activity',
              style: GoogleFonts.manrope(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1B3012),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'VIEW ALL',
                style: GoogleFonts.manrope(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                  color: const Color(0xFF2D4C1B),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFF5F5F4)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(5),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildActivityItem(
                icon: Icons.check_circle,
                iconBg: const Color(0xFFE8F5E9),
                iconColor: const Color(0xFF3D6623),
                title: 'John Doe - Loan Approved',
                subtitle: 'Residential Mortgage Referral',
                time: '2h ago',
              ),
              Divider(
                  height: 1,
                  indent: 20,
                  endIndent: 20,
                  color: const Color(0xFFF5F5F4)),
              _buildActivityItem(
                icon: Icons.description,
                iconBg: const Color(0xFFFAFAF9),
                iconColor: const Color(0xFF78716C),
                title: 'Jane Smith - Application Submitted',
                subtitle: 'Wealth Management Portfolio',
                time: '5h ago',
              ),
              Divider(
                  height: 1,
                  indent: 20,
                  endIndent: 20,
                  color: const Color(0xFFF5F5F4)),
              _buildActivityItem(
                icon: Icons.history_edu,
                iconBg: const Color(0xFFF1C40F).withAlpha(26),
                iconColor: const Color(0xFF917500),
                title: 'Robert Wilson - Document Required',
                subtitle: 'Identity verification pending',
                time: '1d ago',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1B3012),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFA8A29E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortalIndicator() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shield, size: 14, color: AppTheme.onSurface.withAlpha(102)),
          const SizedBox(width: 8),
          Text(
            'INSTITUTIONAL ACCESS PORTAL',
            style: GoogleFonts.manrope(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.5,
              color: AppTheme.onSurface.withAlpha(102),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, '/create-referral'),
      backgroundColor: const Color(0xFF2D4C1B),
      foregroundColor: const Color(0xFFF1C40F),
      elevation: 8,
      child: const Icon(Icons.add, size: 28),
    );
  }

  Widget _buildBottomNav() {
    return Builder(
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(230),
          border: Border(
            top: BorderSide(color: const Color(0xFFF5F5F4)),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(8),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.dashboard, 'DASHBOARD', isActive: true, onTap: () {}),
              _buildNavItem(Icons.group_add, 'REFERRALS', onTap: () {
                Navigator.pushNamed(context, '/referral-list');
              }),
              _buildNavItem(Icons.campaign, 'MARKETING', onTap: () {
                Navigator.pushNamed(context, '/marketing-hub');
              }),
              _buildNavItem(Icons.account_circle, 'PROFILE', onTap: () {
                Navigator.pushNamed(context, '/profile');
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, {bool isActive = false, VoidCallback? onTap}) {
    final color = isActive
        ? const Color(0xFF1B3012)
        : const Color(0xFFA8A29E);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 11,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
              letterSpacing: 2,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
