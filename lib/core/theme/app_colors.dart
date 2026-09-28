import 'package:flutter/material.dart';

/// Neutral-first palette with a single modern accent.
class AppColors {
  AppColors._();

  static const Color background = Color(0xFFF7F6F4);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFEFEEEB);

  static const Color textPrimary = Color(0xFF1C1C1A);
  static const Color textSecondary = Color(0xFF6B6B66);
  static const Color textTertiary = Color(0xFF9A9A94);

  static const Color accent = Color(0xFF0F766E);
  static const Color accentSoft = Color(0xFFCCFBF1);
  static const Color accentPressed = Color(0xFF0D5F59);

  static const Color border = Color(0xFFE6E4DF);
  static const Color borderStrong = Color(0xFFD4D1CA);

  static const Color error = Color(0xFFB42318);
  static const Color errorSoft = Color(0xFFFEF3F2);

  static const Color success = Color(0xFF027A48);
  static const Color shimmerBase = Color(0xFFE8E6E1);
  static const Color shimmerHighlight = Color(0xFFF5F4F1);

  static const Color navInactive = Color(0xFF9A9A94);
  static const Color overlay = Color(0x66000000);
}
