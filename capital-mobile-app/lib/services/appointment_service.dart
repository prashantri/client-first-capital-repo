import '../core/network/api_client.dart';
import '../models/appointment.dart';

class AppointmentService {
  Future<List<Appointment>> getCustomerAppointments() async {
    final response = await api.get('/appointments/customer');
    final list = response.data is List ? response.data : response.data['data'] ?? [];
    return (list as List).map((e) => Appointment.fromJson(e)).toList();
  }

  Future<List<Appointment>> getAdvisorAppointments() async {
    final response = await api.get('/appointments/advisor');
    final list = response.data is List ? response.data : response.data['data'] ?? [];
    return (list as List).map((e) => Appointment.fromJson(e)).toList();
  }

  Future<Appointment> getById(String id) async {
    final response = await api.get('/appointments/$id');
    return Appointment.fromJson(response.data);
  }

  Future<Appointment> create(Map<String, dynamic> data) async {
    final response = await api.post('/appointments', data: data);
    return Appointment.fromJson(response.data);
  }

  Future<Appointment> update(String id, Map<String, dynamic> data) async {
    final response = await api.patch('/appointments/$id', data: data);
    return Appointment.fromJson(response.data);
  }
}
