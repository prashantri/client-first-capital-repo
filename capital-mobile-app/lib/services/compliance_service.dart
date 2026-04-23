import '../core/network/api_client.dart';
import '../models/compliance_checklist.dart';

class ComplianceService {
  Future<List<ComplianceChecklist>> getMyChecklists() async {
    final response = await api.get('/compliance/my');
    final list = response.data is List ? response.data : response.data['data'] ?? [];
    return (list as List).map((e) => ComplianceChecklist.fromJson(e)).toList();
  }

  Future<ComplianceChecklist> update(String id, Map<String, dynamic> data) async {
    final response = await api.patch('/compliance/$id', data: data);
    return ComplianceChecklist.fromJson(response.data);
  }

  Future<ComplianceChecklist> toggleComplete(String id) async {
    final response = await api.patch('/compliance/$id/toggle');
    return ComplianceChecklist.fromJson(response.data);
  }
}
