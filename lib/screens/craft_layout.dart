import 'package:flutter/material.dart';

// ============================================================================
// ATURAN RESPONSIF CRAFTORIGIN (Tahap 3, M06-M07)
// Satu tempat untuk batas lebar layar dan ukuran yang mengikuti layar.
// ============================================================================

/// Batas lebar layar (dalam dp) untuk berpindah susunan.
class CraftBreakpoints {
  CraftBreakpoints._();

  /// Mulai lebar ini, layar dianggap sedang (tablet kecil atau ponsel landscape).
  static const double medium = 600;

  /// Mulai lebar ini, layar dianggap lebar.
  static const double expanded = 900;
}

/// Jumlah kolom grid produk menurut lebar area yang tersedia.
int gridColumnsFor(double width) {
  if (width >= CraftBreakpoints.expanded) return 4;
  if (width >= CraftBreakpoints.medium) return 3;
  return 2;
}

/// Tinggi area teks pada kartu produk (di bawah foto).
///
/// Dikalikan skala huruf yang dipilih pengguna di pengaturan ponsel
/// (MediaQuery), supaya teks yang membesar tidak keluar dari kartu.
double cardInfoHeight(BuildContext context) {
  const baseHeight = 136.0;
  final textScale = MediaQuery.textScalerOf(context).scale(14) / 14;
  return baseHeight * (textScale < 1 ? 1 : textScale);
}
