/// Central app identity — change [appName] to rebrand.
class AppConstants {
  AppConstants._();

  static const String appName = 'AI Photo Studio';
  static const String tagline = 'Create. Transform. Share.';
  static const String homeSubtitle =
      'Turn your photos into something extraordinary.';

  /// Max content width for Flutter Web / large screens.
  static const double maxContentWidth = 1200;

  /// Default API base URL for local development.
  static const String defaultApiBaseUrl = 'http://localhost:8080';
}
