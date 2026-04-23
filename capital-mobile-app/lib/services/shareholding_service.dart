import '../core/network/api_client.dart';
import '../models/shareholding.dart';

class ShareholdingService {
  Future<List<Shareholding>> getMyShareholdings() async {
    final response = await api.get('/shareholdings/my');
    final list = response.data is List ? response.data : response.data['data'] ?? [];
    return (list as List).map((e) => Shareholding.fromJson(e)).toList();
  }
}
