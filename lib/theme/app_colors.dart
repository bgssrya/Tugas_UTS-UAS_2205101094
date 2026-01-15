import 'package:flutter/material.dart';

class AppColors {
  // ================= COLORS =================

  static const Color primary = Color(0xFF8A2BE2);
  static const Color secondary = Color(0xFFFF6B8B);
  static const Color accent = Color(0xFF00D4FF);

  static const Color background = Color(0xFF0F0B1E);
  static const Color cardBackground = Color(0xFF1A1529);
  static const Color surface = Color(0xFF242038);

  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFFE6E1FF);
  static const Color onSurface = Color(0xFFC1B8E6);

  static const Color error = Color(0xFFFF5252);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);

  static const Color divider = Color(0xFF3A3558);

  // ================= GRADIENTS =================

  /// 🔹 Primary gradient (tab, button utama)
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF8A2BE2),
      Color(0xFFFF6B8B),
    ],
  );

  /// 🔹 Accent gradient (logo, icon bulat)
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF00D4FF),
      Color(0xFF9D4EDD),
    ],
  );

  /// 🔹 Card / playlist / music card
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1A1529),
      Color(0xFF242038),
    ],
  );

  /// 🔹 Button horizontal
  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF8A2BE2),
      Color(0xFFFF6B8B),
    ],
  );

  /// 🔹 Background Login & halaman utama
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0F0B1E),
      Color(0xFF1A1529),
      Color(0xFF242038),
    ],
    stops: [0.0, 0.5, 1.0],
  );
}
