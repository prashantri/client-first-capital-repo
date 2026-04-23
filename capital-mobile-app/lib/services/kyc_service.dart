import 'dart:typed_data';
import 'package:dio/dio.dart';
import '../core/network/api_client.dart';
import '../models/kyc_application.dart';

class KycService {
  Future<KycApplication?> getMyKyc() async {
    final response = await api.get('/kyc/my');
    if (response.data == null) return null;
    return KycApplication.fromJson(response.data);
  }

  Future<KycApplication> create(Map<String, dynamic> data) async {
    final response = await api.post('/kyc', data: data);
    return KycApplication.fromJson(response.data);
  }

  Future<KycApplication> update(String id, Map<String, dynamic> data) async {
    final response = await api.patch('/kyc/$id', data: data);
    return KycApplication.fromJson(response.data);
  }

  Future<KycApplication> submit(String id) async {
    final response = await api.post('/kyc/$id/submit');
    return KycApplication.fromJson(response.data);
  }

  Future<void> uploadDocument({
    required String kycId,
    required String documentType,
    required String fileName,
    required Uint8List fileBytes,
  }) async {
    final formData = FormData.fromMap({
      'documentType': documentType,
      'file': MultipartFile.fromBytes(fileBytes, filename: fileName),
    });
    await api.post('/kyc/$kycId/upload-document', data: formData);
  }

  Future<KycApplication> getById(String id) async {
    final response = await api.get('/kyc/$id');
    return KycApplication.fromJson(response.data);
  }
}
