import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Warna tema (light/dark) yang dipakai halaman-halaman Profile.
class PColors {
  final bool isDark;
  final Color heading;
  final Color secondary;
  final Color primary;
  final Color card;
  final Color border;
  final Color soft; // latar ikon / kotak hijau muda

  PColors._(this.isDark, this.heading, this.secondary, this.primary,
      this.card, this.border, this.soft);

  factory PColors.of(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    return PColors._(
      dark,
      dark ? const Color(0xFFF1EFE9) : AppColors.darkGreen,
      dark ? const Color(0xFFBEC8BE) : Colors.grey.shade700,
      dark ? const Color(0xFFA8C9A5) : AppColors.primaryGreen,
      dark ? theme.cardColor : AppColors.card,
      dark ? const Color(0xFF35463A) : AppColors.lightGreenBorder,
      dark ? const Color(0xFF29382F) : AppColors.lightGreen,
    );
  }

  Color get onPrimary => isDark ? AppColors.darkGreen : Colors.white;
}
