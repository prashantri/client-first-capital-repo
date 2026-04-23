class ApiConfig {
  // Android emulator: 10.0.2.2 maps to host localhost
  // iOS simulator: localhost works directly
  // Physical device: use your machine's local IP
  //static const String baseUrl = 'http://10.0.2.2:3000/api/v1';
  static const String baseUrl = 'http://localhost:3000/api/v1';


  // For web or when backend is deployed
  // static const String baseUrl = 'http://localhost:3000/api/v1';

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
}
