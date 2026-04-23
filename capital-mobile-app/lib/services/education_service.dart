import '../core/network/api_client.dart';
import '../models/education_content.dart';

class EducationService {
  Future<List<EducationContent>> getPublished({String? category, int page = 1, int limit = 20}) async {
    final response = await api.get('/education/published', queryParameters: {
      'page': page,
      'limit': limit,
      if (category != null) 'category': category,
    });
    final list = response.data is List ? response.data : response.data['data'] ?? [];
    return (list as List).map((e) => EducationContent.fromJson(e)).toList();
  }

  Future<EducationContent> getById(String id) async {
    final response = await api.get('/education/$id');
    return EducationContent.fromJson(response.data);
  }
}
