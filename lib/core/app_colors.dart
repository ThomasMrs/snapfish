import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF0F1C2F);
  static const Color primarySoft = Color(0xFF162842);
  static const Color accent = Color(0xFF3DA9FC);
  static const Color accentAlt = Color(0xFF8FE5FF);
  static const Color surface = Color(0xFF102038);
  static const Color surfaceAlt = Color(0xFF162C4D);
  static const Color background = Color(0xFF070E19);
  static const Color overlay = Color(0x33102038);

  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFB6C2E2);
  static const Color textMuted = Color(0xFF7F8CA7);
  static const Color success = Color(0xFF6BE6C1);
  static const Color warning = Color(0xFFF4B860);
}

extension ColorCompat on Color {
  Color withOpacityCompat(double opacity) {
    final clamped = opacity.clamp(0.0, 1.0);
    final alpha = (clamped * 255).round().clamp(0, 255);
    return withAlpha(alpha);
  }
}
