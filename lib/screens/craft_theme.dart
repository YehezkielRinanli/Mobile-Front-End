import 'package:flutter/material.dart';

// ============================================================================
// CRAFTORIGIN VISUAL SYSTEM (Tahap 2, M04-M05)
// Material Design 3: skema warna, tipografi, dan skala jarak.
// ============================================================================

/// Skala jarak. Semua Padding, SizedBox, dan margin memakai nilai di sini,
/// bukan angka acak, supaya jarak antar elemen konsisten.
class CraftSpacing {
  CraftSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
}

/// Skala sudut membulat untuk kontainer, kartu, dan badge.
class CraftRadius {
  CraftRadius._();

  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double pill = 999;
}

/// Hijau CraftOrigin, dipakai sebagai warna dasar (seed) skema warna.
const Color _brandGreen = Color(0xFF2A5940);

/// Krem lembut untuk latar halaman, selaras dengan tema ramah lingkungan.
const Color _creamBackground = Color(0xFFF8F5EC);

/// Tema Material 3 untuk halaman Product.
///
/// Cara memakai di sebuah layar:
///   Theme(data: craftTheme, child: Builder(builder: (context) { ... }))
final ThemeData craftTheme = _buildCraftTheme();

ThemeData _buildCraftTheme() {
  // ColorScheme.fromSeed membuat satu set warna Material 3 yang serasi
  // (primary, primaryContainer, surface, outlineVariant, dst.) dari satu
  // warna dasar.
  final colorScheme = ColorScheme.fromSeed(
    seedColor: _brandGreen,
    brightness: Brightness.light,
  );

  final base = ThemeData(useMaterial3: true, colorScheme: colorScheme);
  final text = base.textTheme;

  return base.copyWith(
    scaffoldBackgroundColor: _creamBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
    ),
    // Hierarki tipografi: judul tebal, isi biasa, keterangan kecil.
    textTheme: text.copyWith(
      headlineSmall: text.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
      titleLarge: text.titleLarge?.copyWith(fontWeight: FontWeight.w700),
      titleMedium: text.titleMedium?.copyWith(fontWeight: FontWeight.w700),
      titleSmall: text.titleSmall?.copyWith(fontWeight: FontWeight.w700),
      labelMedium: text.labelMedium?.copyWith(fontWeight: FontWeight.w600),
    ),
  );
}
