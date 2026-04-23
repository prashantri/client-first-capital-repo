import 'package:flutter/material.dart';
import '../models/shareholding.dart';
import '../models/company_valuation.dart';
import '../services/shareholding_service.dart';
import '../services/valuation_service.dart';

class InvestorProvider extends ChangeNotifier {
  final ShareholdingService _shareholdingService = ShareholdingService();
  final ValuationService _valuationService = ValuationService();

  List<Shareholding> _shareholdings = [];
  CompanyValuation? _latestValuation;
  List<CompanyValuation> _valuations = [];
  bool _isLoading = false;
  String? _error;

  List<Shareholding> get shareholdings => _shareholdings;
  CompanyValuation? get latestValuation => _latestValuation;
  List<CompanyValuation> get valuations => _valuations;
  bool get isLoading => _isLoading;
  String? get error => _error;

  double get totalShareValue =>
      _shareholdings.fold(0.0, (sum, s) => sum + s.totalValue);

  int get totalShares =>
      _shareholdings.fold(0, (sum, s) => sum + s.sharesHeld);

  Future<void> loadDashboard() async {
    _isLoading = true;
    notifyListeners();
    try {
      final results = await Future.wait([
        _shareholdingService.getMyShareholdings(),
        _valuationService.getLatest(),
        _valuationService.getAll(),
      ]);
      _shareholdings = results[0] as List<Shareholding>;
      _latestValuation = results[1] as CompanyValuation;
      _valuations = results[2] as List<CompanyValuation>;
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }
}
