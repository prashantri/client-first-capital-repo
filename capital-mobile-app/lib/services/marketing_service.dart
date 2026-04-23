import '../core/network/api_client.dart';
import '../models/marketing_asset.dart';

class MarketingService {
  Future<List<MarketingAsset>> getAssets({String? category, int page = 1, int limit = 20}) async {
    final response = await api.get('/marketing', queryParameters: {
      'page': page,
      'limit': limit,
      if (category != null) 'category': category,
    });
    final list = response.data is List ? response.data : response.data['data'] ?? [];
    return (list as List).map((e) => MarketingAsset.fromJson(e)).toList();
  }

  Future<MarketingAsset> getById(String id) async {
    final response = await api.get('/marketing/$id');
    return MarketingAsset.fromJson(response.data);
  }

  Future<void> trackDownload(String id) async {
    await api.post('/marketing/$id/download');
  }
}
