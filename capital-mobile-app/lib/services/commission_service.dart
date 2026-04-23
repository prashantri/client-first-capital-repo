import '../core/network/api_client.dart';
import '../models/commission.dart';

class CommissionService {
  Future<List<Commission>> getMyCommissions({int page = 1, int limit = 20}) async {
    final response = await api.get('/commissions/my', queryParameters: {
      'page': page,
      'limit': limit,
    });
    final list = response.data is List ? response.data : response.data['data'] ?? [];
    return (list as List).map((e) => Commission.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> getMySummary() async {
    final response = await api.get('/commissions/my/summary');
    return response.data;
  }
}
