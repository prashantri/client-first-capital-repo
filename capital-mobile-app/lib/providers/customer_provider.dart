import 'package:flutter/material.dart';
import '../models/portfolio.dart';
import '../models/goal.dart';
import '../models/appointment.dart';
import '../models/education_content.dart';
import '../services/portfolio_service.dart';
import '../services/goal_service.dart';
import '../services/appointment_service.dart';
import '../services/education_service.dart';

class CustomerProvider extends ChangeNotifier {
  final PortfolioService _portfolioService = PortfolioService();
  final GoalService _goalService = GoalService();
  final AppointmentService _appointmentService = AppointmentService();
  final EducationService _educationService = EducationService();

  List<Portfolio> _portfolios = [];
  List<Goal> _goals = [];
  List<Appointment> _appointments = [];
  List<EducationContent> _educationContent = [];
  bool _isLoading = false;
  String? _error;

  List<Portfolio> get portfolios => _portfolios;
  List<Goal> get goals => _goals;
  List<Appointment> get appointments => _appointments;
  List<EducationContent> get educationContent => _educationContent;
  bool get isLoading => _isLoading;
  String? get error => _error;

  double get totalPortfolioValue =>
      _portfolios.fold(0.0, (sum, p) => sum + p.totalValue);

  Future<void> loadDashboard() async {
    _isLoading = true;
    notifyListeners();
    try {
      final results = await Future.wait([
        _portfolioService.getMyPortfolios(),
        _goalService.getMyGoals(),
        _appointmentService.getCustomerAppointments(),
      ]);
      _portfolios = results[0] as List<Portfolio>;
      _goals = results[1] as List<Goal>;
      _appointments = results[2] as List<Appointment>;
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadPortfolios() async {
    _isLoading = true;
    notifyListeners();
    try {
      _portfolios = await _portfolioService.getMyPortfolios();
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadGoals() async {
    _isLoading = true;
    notifyListeners();
    try {
      _goals = await _goalService.getMyGoals();
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> createGoal(Map<String, dynamic> data) async {
    try {
      final goal = await _goalService.create(data);
      _goals.add(goal);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> loadAppointments() async {
    _isLoading = true;
    notifyListeners();
    try {
      _appointments = await _appointmentService.getCustomerAppointments();
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> bookAppointment(Map<String, dynamic> data) async {
    try {
      final appt = await _appointmentService.create(data);
      _appointments.insert(0, appt);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> loadEducation({String? category}) async {
    _isLoading = true;
    notifyListeners();
    try {
      _educationContent = await _educationService.getPublished(category: category);
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }
}
