import '../core/network/api_client.dart';
import '../models/portfolio.dart';

class PortfolioService {
  Future<List<Portfolio>> getMyPortfolios() async {
    final response = await api.get('/portfolios/my');
    final list = response.data is List ? response.data : response.data['data'] ?? [];
    return (list as List).map((e) => Portfolio.fromJson(e)).toList();
  }

  Future<List<Portfolio>> getAdvisorPortfolios() async {
    final response = await api.get('/portfolios/advisor');
    final list = response.data is List ? response.data : response.data['data'] ?? [];
    return (list as List).map((e) => Portfolio.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> getAdvisorStats() async {
    final response = await api.get('/portfolios/advisor/stats');
    return response.data;
  }

  Future<Portfolio> getById(String id) async {
    final response = await api.get('/portfolios/$id');
    return Portfolio.fromJson(response.data);
  }
}
