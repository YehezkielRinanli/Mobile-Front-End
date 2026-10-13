import 'package:flutter/material.dart';

/// Palet warna CraftOrigin.
/// Nilai hijau utama dan krem diambil dari kode home_screen.dart
/// supaya tampilan antar halaman tetap konsisten.
class AppColors {
  AppColors._(); // Mencegah class ini dibuat objeknya

  // Hijau
  static const Color primaryGreen = Color(0xFF2A5940); // Warna utama
  static const Color darkGreen = Color(0xFF1E3A2B); // Judul onboarding
  static const Color lightGreen = Color(0xFFDCEAD8); // Chip / badge lembut
  static const Color lightGreenBorder = Color(0xFFA9C7A5);

  // Netral
  static const Color cream = Color(0xFFF1EFE9); // Dipakai di CategoryItem
  static const Color background = Color(0xFFF8F5EC); // Latar halaman (desain)
  static const Color card = Color(0xFFFCFAF5); // Latar kartu

  // Aksen
  static const Color terracotta = Color(0xFFB5693B); // Oranye terakota
  static const Color star = Color(0xFFF5A623); // Bintang rating
}
