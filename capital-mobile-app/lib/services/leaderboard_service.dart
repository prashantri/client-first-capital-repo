import '../core/network/api_client.dart';
import '../models/leaderboard_entry.dart';

class LeaderboardService {
  Future<List<LeaderboardEntry>> getLeaderboard({
    required String periodType,
    String? period,
  }) async {
    final response = await api.get('/leaderboard', queryParameters: {
      'periodType': periodType,
      if (period != null) 'period': period,
    });
    final list = response.data is List ? response.data : response.data['data'] ?? [];
    return (list as List).map((e) => LeaderboardEntry.fromJson(e)).toList();
  }

  Future<List<LeaderboardEntry>> getMyRankings() async {
    final response = await api.get('/leaderboard/my');
    final list = response.data is List ? response.data : response.data['data'] ?? [];
    return (list as List).map((e) => LeaderboardEntry.fromJson(e)).toList();
  }
}
