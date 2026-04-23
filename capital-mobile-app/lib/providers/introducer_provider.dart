import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/referral.dart';
import '../models/commission.dart';
import '../models/leaderboard_entry.dart';
import '../models/marketing_asset.dart';
import '../services/referral_service.dart';
import '../services/commission_service.dart';
import '../services/leaderboard_service.dart';
import '../services/marketing_service.dart';

class IntroducerProvider extends ChangeNotifier {
  final ReferralService _referralService = ReferralService();
  final CommissionService _commissionService = CommissionService();
  final LeaderboardService _leaderboardService = LeaderboardService();
  final MarketingService _marketingService = MarketingService();

  List<Referral> _referrals = [];
  Map<String, dynamic> _referralStats = {};
  List<Commission> _commissions = [];
  Map<String, dynamic> _commissionSummary = {};
  List<LeaderboardEntry> _leaderboard = [];
  List<LeaderboardEntry> _myRankings = [];
  List<MarketingAsset> _marketingAssets = [];
  bool _isLoading = false;
  String? _error;

  List<Referral> get referrals => _referrals;
  Map<String, dynamic> get referralStats => _referralStats;
  List<Commission> get commissions => _commissions;
  Map<String, dynamic> get commissionSummary => _commissionSummary;
  List<LeaderboardEntry> get leaderboard => _leaderboard;
  List<LeaderboardEntry> get myRankings => _myRankings;
  List<MarketingAsset> get marketingAssets => _marketingAssets;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadDashboard() async {
    _isLoading = true;
    notifyListeners();
    try {
      final results = await Future.wait([
        _referralService.getMyReferrals(limit: 5),
        _referralService.getMyStats(),
        _commissionService.getMySummary(),
      ]);
      _referrals = results[0] as List<Referral>;
      _referralStats = results[1] as Map<String, dynamic>;
      _commissionSummary = results[2] as Map<String, dynamic>;
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadReferrals({int page = 1}) async {
    _isLoading = true;
    notifyListeners();
    try {
      _referrals = await _referralService.getMyReferrals(page: page);
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> createReferral(Map<String, dynamic> data) async {
    _error = null;
    try {
      final referral = await _referralService.create(data);
      _referrals.insert(0, referral);
      notifyListeners();
      return true;
    } catch (e) {
      _error = _extractError(e);
      notifyListeners();
      return false;
    }
  }

  String _extractError(dynamic e) {
    if (e is DioException) {
      final data = e.response?.data;
      if (data is Map) {
        final msg = data['message'];
        if (msg != null) return msg is List ? msg.join(', ') : msg.toString();
      }
    }
    return e.toString();
  }

  Future<void> loadCommissions({int page = 1}) async {
    _isLoading = true;
    notifyListeners();
    try {
      _commissions = await _commissionService.getMyCommissions(page: page);
      _commissionSummary = await _commissionService.getMySummary();
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadLeaderboard({String periodType = 'monthly'}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final results = await Future.wait([
        _leaderboardService.getLeaderboard(periodType: periodType),
        _leaderboardService.getMyRankings(),
      ]);
      _leaderboard = results[0];
      _myRankings = results[1];
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadMarketingAssets({String? category}) async {
    _isLoading = true;
    notifyListeners();
    try {
      _marketingAssets = await _marketingService.getAssets(category: category);
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }
}
