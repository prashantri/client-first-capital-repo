import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:capital_mobile_app/core/theme/app_theme.dart';

class ReviewStatusScreen extends StatelessWidget {
  const ReviewStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: Column(
        children: [
          _buildAppBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Green hero band
                  _buildHeroBand(),
                  // Main content
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 32),
                        _buildContentSection(),
                        const SizedBox(height: 32),
                        _buildStatusBlock(),
                        const SizedBox(height: 40),
                        _buildActions(context),
                        const SizedBox(height: 40),
                        _buildTrustIndicator(),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildSupportFooter(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.only(top: 48, left: 24, right: 24, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(204),
        border: Border(
          bottom: BorderSide(color: const Color(0xFFF5F5F4)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png', width: 22, height: 22),
          const SizedBox(width: 8),
          Text(
            'CLIENT FIRST CAPITAL',
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1B3D11),
              letterSpacing: -0.8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroBand() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.surfaceContainerHigh,
            AppTheme.surfaceContainerLow,
          ],
        ),
      ),
      child: Center(
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.surfaceContainerLowest,
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withAlpha(20),
                blurRadius: 40,
                offset: const Offset(0, 12),
              ),
            ],
            border: Border.all(
              color: const Color(0xFFF5F5F4),
              width: 1,
            ),
          ),
          child: Center(
            child: Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primaryColor.withAlpha(13),
              ),
              child: const Icon(
                Icons.pending_actions,
                size: 48,
                color: AppTheme.primaryContainer,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContentSection() {
    return Column(
      children: [
        Text(
          'Request Under Review',
          style: GoogleFonts.manrope(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF1B3D11),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Thank you for your application. Our underwriting team is currently conducting a thorough review. You will be notified of our decision shortly.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 15,
            color: AppTheme.onSurfaceVariant,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBlock() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE5E5E5).withAlpha(128),
        ),
      ),
      child: Column(
        children: [
          _buildStatusRow(
            'CURRENT STATUS',
            _buildStatusChip('IN PROGRESS'),
          ),
          const SizedBox(height: 20),
          _buildStatusRow(
            'APPLICATION REFERENCE',
            Text(
              '#CFC-882190',
              style: GoogleFonts.robotoMono(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1B3D11),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildStatusRow(
            'ESTIMATED RESOLUTION',
            Text(
              '1-2 Business Days',
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1B3D11),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, Widget value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
            color: AppTheme.outline,
          ),
        ),
        value,
      ],
    );
  }

  Widget _buildStatusChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFED65B).withAlpha(51),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color(0xFF735C00).withAlpha(51),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.manrope(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 2,
          color: const Color(0xFF735C00),
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Column(
      children: [
        // Return to Dashboard
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/introducer-dashboard', (route) => false);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryContainer,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              elevation: 4,
              shadowColor: AppTheme.primaryColor.withAlpha(51),
            ),
            child: Text(
              'RETURN TO DASHBOARD',
              style: GoogleFonts.manrope(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // View Submission Details
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.primaryContainer,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: BorderSide(color: AppTheme.outlineVariant),
            ),
            child: Text(
              'VIEW SUBMISSION DETAILS',
              style: GoogleFonts.manrope(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTrustIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.verified_user, size: 14, color: AppTheme.outline),
        const SizedBox(width: 8),
        Text(
          'BANK-LEVEL SECURITY & ENCRYPTION',
          style: GoogleFonts.manrope(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.5,
            color: AppTheme.outline,
          ),
        ),
      ],
    );
  }

  Widget _buildSupportFooter() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        border: Border(
          top: BorderSide(color: const Color(0xFFE5E5E5).withAlpha(128)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Requiring assistance? Contact our ',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppTheme.onSurfaceVariant,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              'Institutional Concierge',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppTheme.primaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
