class ApiConfig {
  ApiConfig._();

  /// Override at build time:
  /// flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8080
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8080',
  );

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 60);
}
