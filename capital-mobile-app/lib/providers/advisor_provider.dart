import 'package:flutter/material.dart';
import '../models/referral.dart';
import '../models/portfolio.dart';
import '../models/appointment.dart';
import '../models/compliance_checklist.dart';
import '../services/referral_service.dart';
import '../services/portfolio_service.dart';
import '../services/appointment_service.dart';
import '../services/compliance_service.dart';

class AdvisorProvider extends ChangeNotifier {
  final ReferralService _referralService = ReferralService();
  final PortfolioService _portfolioService = PortfolioService();
  final AppointmentService _appointmentService = AppointmentService();
  final ComplianceService _complianceService = ComplianceService();

  List<Referral> _assignedReferrals = [];
  List<Portfolio> _clientPortfolios = [];
  Map<String, dynamic> _aumStats = {};
  List<Appointment> _appointments = [];
  List<ComplianceChecklist> _checklists = [];
  bool _isLoading = false;
  String? _error;

  List<Referral> get assignedReferrals => _assignedReferrals;
  List<Portfolio> get clientPortfolios => _clientPortfolios;
  Map<String, dynamic> get aumStats => _aumStats;
  List<Appointment> get appointments => _appointments;
  List<ComplianceChecklist> get checklists => _checklists;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadDashboard() async {
    _isLoading = true;
    notifyListeners();
    try {
      final results = await Future.wait([
        _referralService.getAdvisorReferrals(),
        _portfolioService.getAdvisorPortfolios(),
        _portfolioService.getAdvisorStats(),
        _appointmentService.getAdvisorAppointments(),
        _complianceService.getMyChecklists(),
      ]);
      _assignedReferrals = results[0] as List<Referral>;
      _clientPortfolios = results[1] as List<Portfolio>;
      _aumStats = results[2] as Map<String, dynamic>;
      _appointments = results[3] as List<Appointment>;
      _checklists = results[4] as List<ComplianceChecklist>;
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadClientPortfolios() async {
    _isLoading = true;
    notifyListeners();
    try {
      _clientPortfolios = await _portfolioService.getAdvisorPortfolios();
      _aumStats = await _portfolioService.getAdvisorStats();
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadAppointments() async {
    _isLoading = true;
    notifyListeners();
    try {
      _appointments = await _appointmentService.getAdvisorAppointments();
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadChecklists() async {
    _isLoading = true;
    notifyListeners();
    try {
      _checklists = await _complianceService.getMyChecklists();
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleChecklist(String id) async {
    try {
      final updated = await _complianceService.toggleComplete(id);
      final idx = _checklists.indexWhere((c) => c.id == id);
      if (idx != -1) {
        _checklists[idx] = updated;
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateReferralStatus(String id, Map<String, dynamic> data) async {
    try {
      final updated = await _referralService.update(id, data);
      final idx = _assignedReferrals.indexWhere((r) => r.id == id);
      if (idx != -1) {
        _assignedReferrals[idx] = updated;
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
