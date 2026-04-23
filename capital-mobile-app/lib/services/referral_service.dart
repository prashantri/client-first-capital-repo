import '../core/network/api_client.dart';
import '../models/referral.dart';

class ReferralService {
  Future<Referral> create(Map<String, dynamic> data) async {
    final response = await api.post('/referrals', data: data);
    return Referral.fromJson(response.data);
  }

  Future<List<Referral>> getMyReferrals({int page = 1, int limit = 20}) async {
    final response = await api.get('/referrals/my', queryParameters: {
      'page': page,
      'limit': limit,
    });
    final list = response.data is List ? response.data : response.data['data'] ?? [];
    return (list as List).map((e) => Referral.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> getMyStats() async {
    final response = await api.get('/referrals/my/stats');
    return response.data;
  }

  Future<List<Referral>> getAdvisorReferrals() async {
    final response = await api.get('/referrals/advisor');
    final list = response.data is List ? response.data : response.data['data'] ?? [];
    return (list as List).map((e) => Referral.fromJson(e)).toList();
  }

  Future<Referral> getById(String id) async {
    final response = await api.get('/referrals/$id');
    return Referral.fromJson(response.data);
  }

  Future<Referral> update(String id, Map<String, dynamic> data) async {
    final response = await api.patch('/referrals/$id', data: data);
    return Referral.fromJson(response.data);
  }
}
