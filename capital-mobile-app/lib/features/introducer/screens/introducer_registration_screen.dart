import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:capital_mobile_app/core/theme/app_theme.dart';
import 'package:capital_mobile_app/providers/auth_provider.dart';

class IntroducerRegistrationScreen extends StatefulWidget {
  const IntroducerRegistrationScreen({super.key});

  @override
  State<IntroducerRegistrationScreen> createState() =>
      _IntroducerRegistrationScreenState();
}

class _IntroducerRegistrationScreenState
    extends State<IntroducerRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  // Personal info
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  // Professional details
  final _companyController = TextEditingController();
  final _licenseNoController = TextEditingController();

  // Security
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // OTP
  final _otpController = TextEditingController();
  final List<TextEditingController> _otpDigitControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _otpSent = false;
  bool _isSendingOtp = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _scrollController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    _licenseNoController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _otpController.dispose();
    for (final c in _otpDigitControllers) {
      c.dispose();
    }
    for (final f in _otpFocusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _currentOtp =>
      _otpDigitControllers.map((c) => c.text).join();

  bool _validateForm() {
    if (!_formKey.currentState!.validate()) return false;
    if (_passwordController.text != _confirmPasswordController.text) {
      _showError('Passwords do not match');
      return false;
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.primaryContainer,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _handleSendOtp() async {
    if (!_validateForm()) return;

    setState(() => _isSendingOtp = true);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.sendOtp(_emailController.text.trim());
    if (!mounted) return;
    setState(() => _isSendingOtp = false);

    if (success) {
      setState(() => _otpSent = true);
      _showSuccess('OTP sent to ${_emailController.text.trim()}');
      // Scroll to OTP section
      await Future.delayed(const Duration(milliseconds: 300));
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    } else {
      _showError(authProvider.error ?? 'Failed to send OTP');
    }
  }

  Future<void> _handleVerifyAndSubmit() async {
    final otp = _currentOtp;
    if (otp.length < 6) {
      _showError('Please enter the complete 6-digit OTP');
      return;
    }

    setState(() => _isSubmitting = true);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final email = _emailController.text.trim();

    // Verify OTP — if valid, proceed to Step 2 (license document upload)
    final otpValid = await authProvider.verifyOtp(email, otp);
    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (!otpValid) {
      _showError(authProvider.error ?? 'Invalid OTP. Please try again.');
      return;
    }

    // Pass all form data to Step 2 via route arguments
    Navigator.pushNamed(
      context,
      '/registration-step3',
      arguments: {
        'fullName': _fullNameController.text.trim(),
        'email': email,
        'phone': _phoneController.text.trim(),
        'company': _companyController.text.trim(),
        'licenseNo': _licenseNoController.text.trim(),
        'password': _passwordController.text,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: Column(
        children: [
          _buildAppBar(),
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildPageHeader(),
                    const SizedBox(height: 16),
                    _buildInfoCard(),
                    const SizedBox(height: 20),

                    // Section 1 — Personal Information
                    _buildSectionLabel('PERSONAL INFORMATION'),
                    const SizedBox(height: 14),
                    _buildInputField(
                      label: 'FULL NAME',
                      hint: 'John Doe',
                      controller: _fullNameController,
                      icon: Icons.person_outline,
                      keyboardType: TextInputType.name,
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),
                    const SizedBox(height: 14),
                    _buildInputField(
                      label: 'EMAIL ADDRESS',
                      hint: 'john.doe@company.com',
                      controller: _emailController,
                      icon: Icons.mail_outline,
                      keyboardType: TextInputType.emailAddress,
                      enabled: !_otpSent,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Required';
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim())) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    _buildInputField(
                      label: 'PHONE NUMBER',
                      hint: '+971 50 123 4567',
                      controller: _phoneController,
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),

                    const SizedBox(height: 20),

                    // Section 2 — Professional Details
                    _buildSectionLabel('PROFESSIONAL DETAILS'),
                    const SizedBox(height: 14),
                    _buildInputField(
                      label: 'COMPANY NAME',
                      hint: 'Acme Financial Ltd',
                      controller: _companyController,
                      icon: Icons.business_outlined,
                      keyboardType: TextInputType.text,
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),
                    const SizedBox(height: 14),
                    _buildInputField(
                      label: 'ID / LICENSE NUMBER',
                      hint: 'LIC-2024-001234',
                      controller: _licenseNoController,
                      icon: Icons.badge_outlined,
                      keyboardType: TextInputType.text,
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),

                    const SizedBox(height: 20),

                    // Section 3 — Security
                    _buildSectionLabel('SECURITY'),
                    const SizedBox(height: 14),
                    _buildPasswordField(
                      label: 'PASSWORD',
                      hint: 'Min. 8 characters',
                      controller: _passwordController,
                      obscure: _obscurePassword,
                      onToggle: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        if (v.length < 8) return 'Minimum 8 characters';
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    _buildPasswordField(
                      label: 'CONFIRM PASSWORD',
                      hint: 'Re-enter your password',
                      controller: _confirmPasswordController,
                      obscure: _obscureConfirmPassword,
                      onToggle: () => setState(
                          () => _obscureConfirmPassword = !_obscureConfirmPassword),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        if (v != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 32),

                    // Send OTP button (shown when OTP not yet sent)
                    if (!_otpSent) _buildSendOtpButton(),

                    // OTP section (shown after OTP is sent)
                    if (_otpSent) ...[
                      _buildOtpSection(),
                      const SizedBox(height: 24),
                      _buildSubmitButton(),
                    ],

                    const SizedBox(height: 32),
                    _buildFooter(),
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
    final topPadding = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.only(top: topPadding + 8, left: 16, right: 24, bottom: 12),
      decoration: BoxDecoration(color: Colors.white.withAlpha(204)),
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
          Row(
            children: [
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
            ],
          ),
          const Spacer(),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildPageHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'INTRODUCER APPLICATION',
          style: GoogleFonts.manrope(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 3,
            color: AppTheme.primaryContainer,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Become an Introducer',
          style: GoogleFonts.manrope(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppTheme.onSurface,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
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
          Icon(Icons.info_outline, color: AppTheme.primaryContainer, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Submit your application below. Our team will review it and get back to you within 24 hours. You will not be able to log in until your account is approved.',
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

  Widget _buildSectionLabel(String label) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
            color: AppTheme.primaryContainer,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: Divider(color: AppTheme.outlineVariant, thickness: 1)),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    required TextInputType keyboardType,
    String? Function(String?)? validator,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              color: enabled ? AppTheme.onSurfaceVariant : AppTheme.outline,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          enabled: enabled,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: enabled
                ? AppTheme.surfaceContainerLow
                : AppTheme.surfaceContainerHigh,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppTheme.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppTheme.outlineVariant),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppTheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppTheme.primaryColor, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppTheme.error),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            hintStyle: GoogleFonts.inter(
                fontSize: 14, color: const Color(0xFFA8A29E)),
            suffixIcon: Icon(icon,
                color: enabled ? AppTheme.outline : AppTheme.outlineVariant,
                size: 20),
          ),
          style: GoogleFonts.inter(
            fontSize: 14,
            color: enabled ? AppTheme.onSurface : AppTheme.secondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback onToggle,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              color: AppTheme.onSurfaceVariant,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: AppTheme.surfaceContainerLow,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppTheme.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppTheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppTheme.primaryColor, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppTheme.error),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            hintStyle: GoogleFonts.inter(
                fontSize: 14, color: const Color(0xFFA8A29E)),
            suffixIcon: IconButton(
              icon: Icon(
                obscure ? Icons.visibility_off : Icons.visibility,
                color: AppTheme.outline,
                size: 20,
              ),
              onPressed: onToggle,
            ),
          ),
          style: GoogleFonts.inter(fontSize: 14, color: AppTheme.onSurface),
        ),
      ],
    );
  }

  Widget _buildSendOtpButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _isSendingOtp ? null : _handleSendOtp,
        icon: _isSendingOtp
            ? const SizedBox(
                width: 18,
                height: 18,
                child:
                    CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
            : const Icon(Icons.send_outlined, size: 18),
        label: Text(
          _isSendingOtp ? 'Sending OTP...' : 'Send OTP to Email',
          style: GoogleFonts.manrope(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryContainer,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 2,
        ),
      ),
    );
  }

  Widget _buildOtpSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withAlpha(8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primaryColor.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.mark_email_read_outlined,
                  color: AppTheme.primaryContainer, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'OTP Sent',
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.onSurface,
                      ),
                    ),
                    Text(
                      'Check ${_emailController.text.trim()} for your 6-digit code',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppTheme.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: _isSendingOtp ? null : _handleSendOtp,
                child: Text(
                  'Resend',
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'ENTER 6-DIGIT OTP',
            style: GoogleFonts.manrope(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              color: AppTheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(6, (index) => _buildOtpDigitBox(index)),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpDigitBox(int index) {
    return SizedBox(
      width: 44,
      height: 52,
      child: TextFormField(
        controller: _otpDigitControllers[index],
        focusNode: _otpFocusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            _otpFocusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            _otpFocusNodes[index - 1].requestFocus();
          }
        },
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: AppTheme.surfaceContainerLowest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppTheme.outlineVariant),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppTheme.outlineVariant),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        style: GoogleFonts.manrope(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: AppTheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _isSubmitting ? null : _handleVerifyAndSubmit,
        icon: _isSubmitting
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
            : const Icon(Icons.check_circle_outline, size: 18),
        label: Text(
          _isSubmitting ? 'Verifying...' : 'Verify & Continue',
          style: GoogleFonts.manrope(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryContainer,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 4,
          shadowColor: AppTheme.primaryColor.withAlpha(51),
        ),
      ),
    );
  }

  Widget _buildFooter() {
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
