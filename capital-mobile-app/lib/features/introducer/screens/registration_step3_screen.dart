import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:capital_mobile_app/core/theme/app_theme.dart';

class RegistrationStep3Screen extends StatefulWidget {
  const RegistrationStep3Screen({super.key});

  @override
  State<RegistrationStep3Screen> createState() =>
      _RegistrationStep3ScreenState();
}

class _RegistrationStep3ScreenState extends State<RegistrationStep3Screen> {
  String? _panFileName;
  String? _aadhaarFrontFileName;
  String? _aadhaarBackFileName;
  String? _addressProofFileName;

  void _handleSubmit() {
    Navigator.pushNamedAndRemoveUntil(
        context, '/review-status', (route) => false);
  }

  void _simulateUpload(String field) {
    setState(() {
      switch (field) {
        case 'pan':
          _panFileName = 'pan_card.pdf';
          break;
        case 'aadhaar_front':
          _aadhaarFrontFileName = 'aadhaar_front.jpg';
          break;
        case 'aadhaar_back':
          _aadhaarBackFileName = 'aadhaar_back.jpg';
          break;
        case 'address':
          _addressProofFileName = 'utility_bill.pdf';
          break;
      }
    });
  }

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
                    _buildProgressSection(),
                    const SizedBox(height: 24),
                    _buildSecurityNotice(),
                    const SizedBox(height: 24),
                    _buildPanCardSection(),
                    const SizedBox(height: 24),
                    _buildAadhaarSection(),
                    const SizedBox(height: 24),
                    _buildAddressProofSection(),
                    const SizedBox(height: 32),
                    _buildActions(),
                    const SizedBox(height: 32),
                    _buildRegulatoryFooter(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
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
          // Profile avatar placeholder
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFF5F5F4),
              border: Border.all(color: const Color(0xFFE5E5E5)),
            ),
            child: const Icon(Icons.person, size: 18, color: Color(0xFF78716C)),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'VERIFICATION',
                  style: GoogleFonts.manrope(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                    color: AppTheme.primaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'KYC Documents',
                  style: GoogleFonts.manrope(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.onSurface,
                  ),
                ),
              ],
            ),
            RichText(
              text: TextSpan(
                style: GoogleFonts.manrope(fontSize: 14),
                children: [
                  TextSpan(
                    text: 'Step 3 ',
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.onSurface,
                    ),
                  ),
                  TextSpan(
                    text: 'of 3',
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.outline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: 1.0,
            backgroundColor: AppTheme.surfaceContainerHigh,
            valueColor:
                AlwaysStoppedAnimation<Color>(AppTheme.primaryContainer),
            minHeight: 4,
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityNotice() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFD4E8D0).withAlpha(77),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD4E8D0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.verified_user, color: AppTheme.primaryContainer, size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bank-Grade Encryption',
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF111F0F),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your documents are encrypted and stored in a secure digital vault. Only authorized compliance officers can review them.',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppTheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPanCardSection() {
    return _buildDocumentCard(
      icon: Icons.badge_outlined,
      title: 'PAN Card',
      description:
          'Upload the front side of your Permanent Account Number card.',
      child: _buildUploadZone(
        fileName: _panFileName,
        onTap: () => _simulateUpload('pan'),
        label: 'Click to upload or drag and drop',
        sublabel: 'PDF, JPEG, OR PNG (MAX 5MB)',
      ),
    );
  }

  Widget _buildAadhaarSection() {
    return _buildDocumentCard(
      icon: Icons.credit_card_outlined,
      title: 'Aadhaar Card',
      description: 'Please provide both front and back sides of your Aadhaar.',
      child: Row(
        children: [
          Expanded(
            child: _buildUploadZone(
              fileName: _aadhaarFrontFileName,
              onTap: () => _simulateUpload('aadhaar_front'),
              label: 'Front Side',
              compact: true,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildUploadZone(
              fileName: _aadhaarBackFileName,
              onTap: () => _simulateUpload('aadhaar_back'),
              label: 'Back Side',
              compact: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressProofSection() {
    return _buildDocumentCard(
      icon: Icons.receipt_long_outlined,
      title: 'Address Proof',
      description:
          'Utility Bill (Electricity, Water), Rent Agreement, or Voter ID.',
      child: _buildUploadZone(
        fileName: _addressProofFileName,
        onTap: () => _simulateUpload('address'),
        label: 'Upload Proof of Address',
        sublabel: 'DOCUMENT SHOULD NOT BE OLDER THAN 3 MONTHS',
      ),
    );
  }

  Widget _buildDocumentCard({
    required IconData icon,
    required String title,
    required String description,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E5E5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAF9),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xFFF5F5F4)),
                ),
                child: Icon(icon, color: AppTheme.primaryContainer, size: 20),
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
                        color: AppTheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppTheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }

  Widget _buildUploadZone({
    required String? fileName,
    required VoidCallback onTap,
    required String label,
    String? sublabel,
    bool compact = false,
  }) {
    final isUploaded = fileName != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(compact ? 20 : 32),
        decoration: BoxDecoration(
          color: isUploaded
              ? const Color(0xFFD4E8D0).withAlpha(51)
              : const Color(0xFFFAFAF9),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isUploaded
                ? AppTheme.primaryContainer
                : AppTheme.outlineVariant,
            width: isUploaded ? 1 : 2,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isUploaded ? Icons.check_circle : Icons.cloud_upload_outlined,
              color:
                  isUploaded ? AppTheme.primaryContainer : AppTheme.outline,
              size: compact ? 24 : 32,
            ),
            const SizedBox(height: 8),
            Text(
              isUploaded ? fileName! : label,
              style: GoogleFonts.manrope(
                fontSize: compact ? 12 : 14,
                fontWeight: FontWeight.w700,
                color: isUploaded
                    ? AppTheme.primaryContainer
                    : AppTheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            if (sublabel != null && !isUploaded) ...[
              const SizedBox(height: 4),
              Text(
                sublabel,
                style: GoogleFonts.manrope(
                  fontSize: 9,
                  letterSpacing: 1.5,
                  color: AppTheme.outline,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Column(
      children: [
        // Submit button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _handleSubmit,
            icon: const Icon(Icons.check_circle, size: 18),
            label: Text(
              'Submit Application',
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryContainer,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 4,
              shadowColor: AppTheme.primaryColor.withAlpha(51),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Back button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, size: 18),
            label: Text(
              'Back to Step 2',
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.primaryContainer,
              backgroundColor: const Color(0xFFF5F5F4),
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              side: const BorderSide(color: Color(0xFFE5E5E5)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegulatoryFooter() {
    return Center(
      child: Text(
        'BY SUBMITTING, YOU AGREE TO OUR TERMS OF SERVICE\nAND PRIVACY POLICY.\nCLIENT FIRST CAPITAL IS A SEBI REGISTERED ENTITY.',
        textAlign: TextAlign.center,
        style: GoogleFonts.manrope(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.5,
          color: AppTheme.outline,
          height: 1.6,
        ),
      ),
    );
  }
}
