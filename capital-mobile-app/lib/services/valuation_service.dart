import '../core/network/api_client.dart';
import '../models/company_valuation.dart';

class ValuationService {
  Future<List<CompanyValuation>> getAll() async {
    final response = await api.get('/valuations');
    final list = response.data is List ? response.data : response.data['data'] ?? [];
    return (list as List).map((e) => CompanyValuation.fromJson(e)).toList();
  }

  Future<CompanyValuation> getLatest() async {
    final response = await api.get('/valuations/latest');
    return CompanyValuation.fromJson(response.data);
  }
}
