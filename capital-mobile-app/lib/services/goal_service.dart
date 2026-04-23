import '../core/network/api_client.dart';
import '../models/goal.dart';

class GoalService {
  Future<List<Goal>> getMyGoals() async {
    final response = await api.get('/goals/my');
    final list = response.data is List ? response.data : response.data['data'] ?? [];
    return (list as List).map((e) => Goal.fromJson(e)).toList();
  }

  Future<Goal> getById(String id) async {
    final response = await api.get('/goals/$id');
    return Goal.fromJson(response.data);
  }

  Future<Goal> create(Map<String, dynamic> data) async {
    final response = await api.post('/goals', data: data);
    return Goal.fromJson(response.data);
  }

  Future<Goal> update(String id, Map<String, dynamic> data) async {
    final response = await api.patch('/goals/$id', data: data);
    return Goal.fromJson(response.data);
  }

  Future<void> delete(String id) async {
    await api.delete('/goals/$id');
  }
}
