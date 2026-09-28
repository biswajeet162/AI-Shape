import 'package:flutter/material.dart';

/// Corner radius tokens for cards, buttons, and sheets.
class AppRadius {
  AppRadius._();

  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double button = 16;
  static const double image = 20;
  static const double chip = 20;
  static const double bottomSheet = 24;

  static final BorderRadius card = BorderRadius.circular(md);
  static final BorderRadius cardLg = BorderRadius.circular(lg);
  static final BorderRadius buttonAll = BorderRadius.circular(button);
  static final BorderRadius imageAll = BorderRadius.circular(image);
  static final BorderRadius chipAll = BorderRadius.circular(chip);
  static final BorderRadius sheetTop = const BorderRadius.vertical(
    top: Radius.circular(bottomSheet),
  );
}
