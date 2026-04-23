import 'dart:typed_data';
import 'package:dio/dio.dart';
import '../core/network/api_client.dart';
import '../core/network/token_storage.dart';
import '../models/user.dart';

class AuthService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await api.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    return response.data;
  }

  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String phone,
    required String firstName,
    required String lastName,
    required String role,
  }) async {
    final response = await api.post('/auth/register', data: {
      'email': email,
      'password': password,
      'phone': phone,
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
    });
    return response.data;
  }

  Future<void> sendOtp(String email) async {
    await api.post('/auth/send-otp', data: {'email': email});
  }

  Future<bool> verifyOtp(String email, String otp) async {
    final response = await api.post('/auth/verify-otp', data: {
      'email': email,
      'otp': otp,
    });
    return response.data['verified'] == true;
  }

  /// Sends all form data + optional license document as multipart/form-data.
  Future<String> registerIntroducer({
    required String fullName,
    required String email,
    required String phone,
    required String company,
    required String licenseNo,
    required String password,
    Uint8List? licenseFileBytes,
    String? licenseFileName,
  }) async {
    final formData = FormData.fromMap({
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'company': company,
      'licenseNo': licenseNo,
      'password': password,
      if (licenseFileBytes != null)
        'licenseDocument': MultipartFile.fromBytes(
          licenseFileBytes,
          filename: licenseFileName ?? 'license_document.pdf',
        ),
    });

    final response = await api.post(
      '/auth/register-introducer',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
    return response.data['message'] as String;
  }

  Future<void> updateBankDetails({
    required String bankName,
    required String accountName,
    required String accountNumber,
    String? iban,
  }) async {
    await api.patch('/users/me/bank-details', data: {
      'bankName': bankName,
      'accountName': accountName,
      'accountNumber': accountNumber,
      if (iban != null && iban.isNotEmpty) 'iban': iban,
    });
  }

  Future<User> getProfile() async {
    final response = await api.get('/auth/profile');
    return User.fromJson(response.data);
  }

  Future<void> forgotPassword(String email) async {
    await api.post('/auth/forgot-password', data: {'email': email});
  }

  Future<void> resetPassword(String email, String otp, String newPassword) async {
    await api.post('/auth/reset-password', data: {
      'email': email,
      'otp': otp,
      'newPassword': newPassword,
    });
  }

  Future<void> logout() async {
    await TokenStorage.deleteToken();
  }
}
