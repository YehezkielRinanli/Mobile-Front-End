import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const CraftOriginApp());
}

class CraftOriginApp extends StatelessWidget {
  const CraftOriginApp({super.key});

  // Design tokens utama agar warna dan bentuk konsisten di seluruh aplikasi.
  static const Color primaryGreen = Color(0xFF2A5940);
  static const Color pageBackground = Color(0xFFFAF9F6);
  static const Color textPrimary = Color(0xFF1D2B22);

  @override
  Widget build(BuildContext context) {
    final ColorScheme craftColorScheme = ColorScheme.fromSeed(
      seedColor: primaryGreen,
      brightness: Brightness.light,
    ).copyWith(surface: pageBackground);

    return MaterialApp(
      title: 'CraftOrigin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Material 3 diaktifkan secara global.
        useMaterial3: true,
        colorScheme: craftColorScheme,
        scaffoldBackgroundColor: pageBackground,
        fontFamily: 'Roboto',

        // Sistem tipografi yang dipakai ulang di berbagai layar.
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            height: 1.2,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 1.25,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 1.25,
          ),
          bodyLarge: TextStyle(fontSize: 16, height: 1.45),
          bodyMedium: TextStyle(fontSize: 14, height: 1.45),
          bodySmall: TextStyle(fontSize: 12, height: 1.4),
          labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ).apply(bodyColor: textPrimary, displayColor: textPrimary),

        // Bentuk komponen input yang seragam.
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFFF0F2EE),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: primaryGreen, width: 1.5),
          ),
        ),

        // Gaya tombol global dengan bentuk rounded khas desain aplikasi.
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: primaryGreen,
            elevation: 0,
            minimumSize: const Size(48, 48),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: primaryGreen,
            elevation: 0,
            minimumSize: const Size(48, 48),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primaryGreen,
            textStyle: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),

        // NavigationBar adalah komponen navigasi Material 3.
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: Color(0xFFDDE9DF),
          elevation: 0,
          height: 72,
        ),
        dividerTheme: const DividerThemeData(
          color: Color(0xFFE7E9E4),
          thickness: 1,
          space: 1,
        ),
      ),
      home: const HomeScreen(), // Mengarahkan langsung ke halaman Home
    );
  }
}