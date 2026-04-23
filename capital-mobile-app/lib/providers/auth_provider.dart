import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../core/network/token_storage.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  User? _user;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;
  String? get error => _error;
  String get userRole => _user?.role ?? '';
  bool get isPending => _user?.status == 'pending';

  Future<bool> tryAutoLogin() async {
    final hasToken = await TokenStorage.hasToken();
    if (!hasToken) return false;
    try {
      _user = await _authService.getProfile();
      notifyListeners();
      return true;
    } catch (_) {
      await TokenStorage.deleteToken();
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final data = await _authService.login(email, password);
      await TokenStorage.saveToken(data['accessToken']);
      _user = User.fromJson(data['user']);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = _extractError(e);
      notifyListeners();
      return false;
    }
  }

  Future<bool> register({
    required String email,
    required String password,
    required String phone,
    required String firstName,
    required String lastName,
    required String role,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final data = await _authService.register(
        email: email,
        password: password,
        phone: phone,
        firstName: firstName,
        lastName: lastName,
        role: role,
      );
      await TokenStorage.saveToken(data['accessToken']);
      _user = User.fromJson(data['user']);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = _extractError(e);
      notifyListeners();
      return false;
    }
  }

  /// Sends OTP to the given email for introducer registration verification.
  Future<bool> sendOtp(String email) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await _authService.sendOtp(email);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = _extractError(e);
      notifyListeners();
      return false;
    }
  }

  /// Verifies OTP entered by the user. Returns true if valid.
  Future<bool> verifyOtp(String email, String otp) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final verified = await _authService.verifyOtp(email, otp);
      _isLoading = false;
      notifyListeners();
      return verified;
    } catch (e) {
      _isLoading = false;
      _error = _extractError(e);
      notifyListeners();
      return false;
    }
  }

  /// Submits the introducer registration with optional license document.
  /// Does NOT log the user in — account is left in 'pending' status until admin approval.
  Future<bool> registerIntroducer({
    required String fullName,
    required String email,
    required String phone,
    required String company,
    required String licenseNo,
    required String password,
    Uint8List? licenseFileBytes,
    String? licenseFileName,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await _authService.registerIntroducer(
        fullName: fullName,
        email: email,
        phone: phone,
        company: company,
        licenseNo: licenseNo,
        password: password,
        licenseFileBytes: licenseFileBytes,
        licenseFileName: licenseFileName,
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = _extractError(e);
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateBankDetails({
    required String bankName,
    required String accountName,
    required String accountNumber,
    String? iban,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await _authService.updateBankDetails(
        bankName: bankName,
        accountName: accountName,
        accountNumber: accountNumber,
        iban: iban,
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = _extractError(e);
      notifyListeners();
      return false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await _authService.forgotPassword(email);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = _extractError(e);
      notifyListeners();
      return false;
    }
  }

  Future<bool> resetPassword(String email, String otp, String newPassword) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await _authService.resetPassword(email, otp, newPassword);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = _extractError(e);
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  String _extractError(dynamic e) {
    if (e is DioException) {
      final data = e.response?.data;
      // Read the actual message from the backend response body first
      if (data is Map) {
        final serverMsg = data['message'];
        if (serverMsg != null) {
          final text = serverMsg is List
              ? (serverMsg as List).join(', ')
              : serverMsg.toString();
          // Normalise the pending-review message
          if (text.toLowerCase().contains('pending')) {
            return 'Your application is pending review. You will be notified within 24 hours.';
          }
          return text;
        }
      }
      // Fallback by status code when response body has no message
      final status = e.response?.statusCode;
      if (status == 401) return 'Invalid email or password';
      if (status == 409) return 'An account with this email already exists';
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.unknown) {
        return 'Unable to connect to server. Please check your connection.';
      }
    }
    return 'Something went wrong. Please try again.';
  }

  String getHomeRoute() {
    switch (_user?.role) {
      case 'introducer':
        return '/introducer-dashboard';
      case 'advisor':
        return '/advisor';
      case 'customer':
        return '/customer';
      case 'investor':
        return '/investor';
      default:
        return '/welcome';
    }
  }
}
