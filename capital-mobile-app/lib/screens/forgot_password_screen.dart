import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:capital_mobile_app/core/theme/app_theme.dart';
import 'package:capital_mobile_app/providers/auth_provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // step 0 = email, step 1 = OTP, step 2 = new password
  int _step = 0;

  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureNew = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  String _email = '';

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSendOtp() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      _showError('Please enter your email address.');
      return;
    }
    setState(() => _isLoading = true);
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final ok = await auth.forgotPassword(email);
    if (!mounted) return;
    setState(() => _isLoading = false);
    if (ok) {
      _email = email;
      setState(() => _step = 1);
    } else {
      _showError(auth.error ?? 'Failed to send reset code.');
    }
  }

  Future<void> _handleVerifyOtp() async {
    final otp = _otpController.text.trim();
    if (otp.length != 6) {
      _showError('Please enter the 6-digit code sent to your email.');
      return;
    }
    setState(() => _step = 2);
  }

  Future<void> _handleResetPassword() async {
    final newPassword = _newPasswordController.text;
    final confirm = _confirmPasswordController.text;
    if (newPassword.length < 8) {
      _showError('Password must be at least 8 characters.');
      return;
    }
    if (newPassword != confirm) {
      _showError('Passwords do not match.');
      return;
    }
    setState(() => _isLoading = true);
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final ok = await auth.resetPassword(_email, _otpController.text.trim(), newPassword);
    if (!mounted) return;
    setState(() => _isLoading = false);
    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset successfully. Please log in.'),
          backgroundColor: AppTheme.primaryColor,
        ),
      );
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      _showError(auth.error ?? 'Failed to reset password. Please try again.');
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: const Color(0xFFB91C1C)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceContainerLowest,
      body: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    _buildStepIndicator(),
                    const SizedBox(height: 32),
                    if (_step == 0) _buildEmailStep(),
                    if (_step == 1) _buildOtpStep(),
                    if (_step == 2) _buildNewPasswordStep(),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        left: 16,
        right: 24,
        bottom: 16,
      ),
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

  Widget _buildStepIndicator() {
    final labels = ['Email', 'Verify', 'Reset'];
    return Row(
      children: List.generate(3, (i) {
        final isActive = i == _step;
        final isDone = i < _step;
        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDone
                            ? AppTheme.primaryColor
                            : isActive
                                ? AppTheme.primaryColor
                                : const Color(0xFFE5E7EB),
                      ),
                      child: Center(
                        child: isDone
                            ? const Icon(Icons.check, color: Colors.white, size: 16)
                            : Text(
                                '${i + 1}',
                                style: GoogleFonts.manrope(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: isActive ? Colors.white : const Color(0xFF9CA3AF),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      labels[i],
                      style: GoogleFonts.manrope(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isActive || isDone ? AppTheme.primaryColor : const Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
              ),
              if (i < 2)
                Container(
                  width: 40,
                  height: 2,
                  margin: const EdgeInsets.only(bottom: 22),
                  color: i < _step ? AppTheme.primaryColor : const Color(0xFFE5E7EB),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildEmailStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Forgot Password',
          style: GoogleFonts.manrope(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppTheme.onSurface,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Enter your registered email address and we\'ll send you a reset code.',
          style: GoogleFonts.inter(
            fontSize: 15,
            color: AppTheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 32),
        _fieldLabel('EMAIL ADDRESS'),
        const SizedBox(height: 6),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          autofocus: true,
          decoration: _inputDecoration('Enter your email address'),
          style: GoogleFonts.inter(fontSize: 14, color: AppTheme.onSurface),
        ),
        const SizedBox(height: 32),
        _primaryButton(
          label: 'Send Reset Code',
          onPressed: _isLoading ? null : _handleSendOtp,
          isLoading: _isLoading,
        ),
      ],
    );
  }

  Widget _buildOtpStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Check Your Email',
          style: GoogleFonts.manrope(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppTheme.onSurface,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: GoogleFonts.inter(fontSize: 15, color: AppTheme.onSurfaceVariant, height: 1.5),
            children: [
              const TextSpan(text: 'We sent a 6-digit code to '),
              TextSpan(
                text: _email,
                style: const TextStyle(fontWeight: FontWeight.w700, color: AppTheme.primaryColor),
              ),
              const TextSpan(text: '. Enter it below.'),
            ],
          ),
        ),
        const SizedBox(height: 32),
        _fieldLabel('RESET CODE'),
        const SizedBox(height: 6),
        TextField(
          controller: _otpController,
          keyboardType: TextInputType.number,
          maxLength: 6,
          autofocus: true,
          textAlign: TextAlign.center,
          decoration: _inputDecoration('• • • • • •').copyWith(
            counterText: '',
            hintStyle: GoogleFonts.inter(fontSize: 24, color: const Color(0xFFA8A29E), letterSpacing: 8),
          ),
          style: GoogleFonts.manrope(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: 12,
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: _isLoading ? null : _handleSendOtp,
              child: Text(
                'Resend code',
                style: GoogleFonts.manrope(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        _primaryButton(
          label: 'Continue',
          onPressed: _isLoading ? null : _handleVerifyOtp,
          isLoading: _isLoading,
        ),
      ],
    );
  }

  Widget _buildNewPasswordStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Set New Password',
          style: GoogleFonts.manrope(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppTheme.onSurface,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Choose a strong password with at least 8 characters.',
          style: GoogleFonts.inter(
            fontSize: 15,
            color: AppTheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 32),
        _fieldLabel('NEW PASSWORD'),
        const SizedBox(height: 6),
        TextField(
          controller: _newPasswordController,
          obscureText: _obscureNew,
          autofocus: true,
          decoration: _inputDecoration('Minimum 8 characters').copyWith(
            suffixIcon: IconButton(
              icon: Icon(
                _obscureNew ? Icons.visibility_off : Icons.visibility,
                color: AppTheme.outline,
                size: 20,
              ),
              onPressed: () => setState(() => _obscureNew = !_obscureNew),
            ),
          ),
          style: GoogleFonts.inter(fontSize: 14, color: AppTheme.onSurface),
        ),
        const SizedBox(height: 20),
        _fieldLabel('CONFIRM PASSWORD'),
        const SizedBox(height: 6),
        TextField(
          controller: _confirmPasswordController,
          obscureText: _obscureConfirm,
          decoration: _inputDecoration('Re-enter new password').copyWith(
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                color: AppTheme.outline,
                size: 20,
              ),
              onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
            ),
          ),
          style: GoogleFonts.inter(fontSize: 14, color: AppTheme.onSurface),
        ),
        const SizedBox(height: 32),
        _primaryButton(
          label: 'Reset Password',
          onPressed: _isLoading ? null : _handleResetPassword,
          isLoading: _isLoading,
        ),
      ],
    );
  }

  Widget _fieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: GoogleFonts.manrope(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.5,
          color: AppTheme.secondaryColor,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: GoogleFonts.inter(fontSize: 14, color: const Color(0xFFA8A29E)),
    );
  }

  Widget _primaryButton({
    required String label,
    required VoidCallback? onPressed,
    required bool isLoading,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryContainer,
          foregroundColor: AppTheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 2,
          shadowColor: AppTheme.primaryColor.withAlpha(51),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
            : Text(
                label,
                style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w700),
              ),
      ),
    );
  }
}
