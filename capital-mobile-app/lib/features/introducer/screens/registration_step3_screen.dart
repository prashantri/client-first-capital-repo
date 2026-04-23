import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:capital_mobile_app/core/theme/app_theme.dart';
import 'package:capital_mobile_app/providers/auth_provider.dart';

class RegistrationStep3Screen extends StatefulWidget {
  const RegistrationStep3Screen({super.key});

  @override
  State<RegistrationStep3Screen> createState() =>
      _RegistrationStep3ScreenState();
}

class _RegistrationStep3ScreenState extends State<RegistrationStep3Screen> {
  String? _licenseFileName;
  Uint8List? _licenseFileBytes;
  bool _isSubmitting = false;

  // Form data received from Step 1
  Map<String, dynamic> _formData = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic>) {
      _formData = args;
    }
  }

  Future<void> _pickLicenseFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      withData: true,
    );
    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _licenseFileName = result.files.single.name;
        _licenseFileBytes = result.files.single.bytes;
      });
    }
  }

  Future<void> _handleSubmit() async {
    if (_licenseFileBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please upload your License / ID document to continue'),
          backgroundColor: AppTheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final success = await authProvider.registerIntroducer(
      fullName: _formData['fullName'] ?? '',
      email: _formData['email'] ?? '',
      phone: _formData['phone'] ?? '',
      company: _formData['company'] ?? '',
      licenseNo: _formData['licenseNo'] ?? '',
      password: _formData['password'] ?? '',
      licenseFileBytes: _licenseFileBytes,
      licenseFileName: _licenseFileName,
    );

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (success) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/review-status', (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.error ?? 'Submission failed. Please try again.'),
          backgroundColor: AppTheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
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
                    const SizedBox(height: 28),
                    _buildLicenseSection(),
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
        border: Border(bottom: BorderSide(color: const Color(0xFFF5F5F4))),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  Icon(Icons.arrow_back, color: AppTheme.primaryColor, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Back',
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Image.asset('assets/images/logo.png', width: 22, height: 22),
          const SizedBox(width: 8),
          Text(
            'Client First Capital',
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppTheme.primaryColor,
              letterSpacing: -0.8,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 56),
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
                  'STEP 2 OF 2',
                  style: GoogleFonts.manrope(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 3,
                    color: AppTheme.primaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'License Document',
                  style: GoogleFonts.manrope(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.onSurface,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: 1.0,
            backgroundColor: AppTheme.surfaceContainerHigh,
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryContainer),
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
        color: AppTheme.primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.primaryColor.withAlpha(40)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.verified_user, color: AppTheme.primaryContainer, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Upload a clear copy of your financial license or government-issued ID. This document is encrypted and reviewed only by authorised compliance officers.',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppTheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLicenseSection() {
    return _buildDocumentCard(
      icon: Icons.badge_outlined,
      title: 'License / ID Document',
      description:
          'Financial license, broker license, or government-issued ID that confirms your authority to introduce clients.',
      child: _buildUploadZone(),
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

  Widget _buildUploadZone() {
    final isUploaded = _licenseFileName != null;

    return GestureDetector(
      onTap: _pickLicenseFile,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        decoration: BoxDecoration(
          color: isUploaded
              ? AppTheme.primaryColor.withAlpha(13)
              : const Color(0xFFFAFAF9),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isUploaded ? AppTheme.primaryContainer : AppTheme.outlineVariant,
            width: isUploaded ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isUploaded ? Icons.check_circle : Icons.cloud_upload_outlined,
              color: isUploaded ? AppTheme.primaryContainer : AppTheme.outline,
              size: 40,
            ),
            const SizedBox(height: 12),
            Text(
              isUploaded ? _licenseFileName! : 'Tap to upload document',
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isUploaded ? AppTheme.primaryContainer : AppTheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            if (!isUploaded) ...[
              const SizedBox(height: 6),
              Text(
                'PDF, JPEG OR PNG  •  MAX 5MB',
                style: GoogleFonts.manrope(
                  fontSize: 10,
                  letterSpacing: 1.5,
                  color: AppTheme.outline,
                ),
              ),
            ],
            if (isUploaded) ...[
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _pickLicenseFile,
                child: Text(
                  'Replace file',
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
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
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _isSubmitting ? null : _handleSubmit,
            icon: _isSubmitting
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                : const Icon(Icons.check_circle_outline, size: 18),
            label: Text(
              _isSubmitting ? 'Submitting Application...' : 'Submit Application',
              style: GoogleFonts.manrope(
                  fontSize: 15, fontWeight: FontWeight.w800),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryContainer,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              elevation: 4,
              shadowColor: AppTheme.primaryColor.withAlpha(51),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, size: 18),
            label: Text(
              'Back to Step 1',
              style: GoogleFonts.manrope(
                  fontSize: 14, fontWeight: FontWeight.w700),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.primaryContainer,
              backgroundColor: const Color(0xFFF5F5F4),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
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
        'BY SUBMITTING YOU AGREE TO OUR TERMS OF SERVICE\nAND PRIVACY POLICY.',
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
