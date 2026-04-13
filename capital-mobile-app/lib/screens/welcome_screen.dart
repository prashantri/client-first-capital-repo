import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:capital_mobile_app/core/theme/app_theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: Column(
        children: [
          // --- Frosted Glass Top App Bar ---
          _buildAppBar(),

          // --- Scrollable Content ---
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 32),

                    // --- Branding Section ---
                    _buildBrandingSection(),

                    const SizedBox(height: 40),

                    // --- Performance Highlight Card ---
                    _buildPerformanceCard(),

                    const SizedBox(height: 40),

                    // --- Action Buttons ---
                    _buildActionButtons(context),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),

          // --- Footer ---
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.only(top: 48, left: 24, right: 24, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(179),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_balance,
                color: AppTheme.primaryColor.withAlpha(204),
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Client First Capital',
                style: GoogleFonts.manrope(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF14532D),
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
              color: AppTheme.onSurface,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandingSection() {
    return Column(
      children: [
        // Tree logo container
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(20),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            'assets/images/logo.png',
            width: 56,
            height: 56,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Your Trust, Our Asset',
          style: GoogleFonts.manrope(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppTheme.primaryColor,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'We create wealth by making your money work hard so you can make your dreams and aspirations come true.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppTheme.secondaryColor,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withAlpha(25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Subtle dot-grid texture overlay
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CustomPaint(
                painter: _DotGridPainter(),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    const Icon(
                      Icons.trending_up,
                      color: AppTheme.onPrimaryContainer,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'INSTITUTIONAL PERFORMANCE',
                      style: GoogleFonts.manrope(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 3,
                        color: AppTheme.onPrimaryContainer.withAlpha(204),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  "Founder's Portfolio Excellence",
                  style: GoogleFonts.manrope(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.onPrimaryContainer,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppTheme.onPrimaryContainer.withAlpha(230),
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      const TextSpan(
                          text:
                              "In 2020 our Founder's Portfolio outperformed the "),
                      TextSpan(
                        text: 'S&P 500 by ~16%',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const TextSpan(
                          text:
                              ', the EAFE Index by 22%, and the Vanguard Total World Index by 20%.'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Divider
                Container(
                  height: 1,
                  color: AppTheme.onPrimaryContainer.withAlpha(51),
                ),
                const SizedBox(height: 16),
                // Bottom row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Avatar stack
                    SizedBox(
                      width: 44,
                      height: 24,
                      child: Stack(
                        children: [
                          _buildAvatar(0),
                          Positioned(left: 16, child: _buildAvatar(1)),
                        ],
                      ),
                    ),
                    Text(
                      'JOIN 500+ INVESTORS',
                      style: GoogleFonts.manrope(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.onPrimaryContainer.withAlpha(179),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(int index) {
    final colors = [const Color(0xFF6B7280), const Color(0xFF9CA3AF)];
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors[index],
        border: Border.all(color: AppTheme.primaryContainer, width: 2),
      ),
      child: const Icon(Icons.person, size: 12, color: Colors.white),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        // LOGIN — Golden CTA
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.tertiaryColor,
              foregroundColor: AppTheme.onTertiary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 4,
              shadowColor: AppTheme.tertiaryColor.withAlpha(51),
            ),
            child: Text(
              'LOGIN',
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // BECOME AN INTRODUCER — Outlined
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/registration-step1');
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              side: BorderSide(color: AppTheme.primaryColor.withAlpha(26)),
            ),
            child: Text(
              'BECOME AN INTRODUCER',
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppTheme.outlineVariant.withAlpha(77),
          ),
        ),
      ),
      child: Column(
        children: [
          // Links row
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 32,
            runSpacing: 8,
            children: [
              _buildFooterLink('PRIVACY POLICY'),
              _buildFooterLink('TERMS OF SERVICE'),
              _buildFooterLink('CONTACT'),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '© 2026 CLIENT FIRST CAPITAL. ALL RIGHTS RESERVED.',
            style: GoogleFonts.inter(
              fontSize: 10,
              letterSpacing: 2,
              color: AppTheme.outline.withAlpha(153),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 2,
        color: AppTheme.secondaryColor,
      ),
    );
  }
}

/// Subtle dot-grid painter for the performance card overlay
class _DotGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withAlpha(25)
      ..style = PaintingStyle.fill;

    const spacing = 16.0;
    const radius = 0.8;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
