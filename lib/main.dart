import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/splash_screen.dart';

Future<void> main() async {
  // Wajib dipanggil sebelum memakai plugin/service Flutter sebelum runApp.
  WidgetsFlutterBinding.ensureInitialized();

  // [M07] Orientasi dinyatakan eksplisit: portrait dan landscape diizinkan,
  // karena layar-layar aplikasi sudah beradaptasi dengan orientasi.
  await SystemChrome.setPreferredOrientations(const [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const CraftOriginApp());
}

class CraftOriginApp extends StatelessWidget {
  const CraftOriginApp({super.key});

  // Design tokens utama agar warna dan bentuk konsisten di seluruh aplikasi.
  static const Color primaryGreen = Color(0xFF2A5940);
  static const Color pageBackground = Color(0xFFFAF9F6);
  static const Color textPrimary = Color(0xFF1D2B22);

  // [M07] Batas skala teks sistem (aksesibilitas). Nilai ini sama dengan clamp
  // di HomeScreen dan ExploreScreen.
  static const double _minTextScale = 1.0;
  static const double _maxTextScale = 1.4;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CraftOrigin',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),

      // [M07] builder membungkus SEMUA halaman. MediaQuery di bawahnya
      // memiliki skala teks yang sudah dibatasi, sehingga layout tidak pecah
      // saat pengguna memperbesar teks di pengaturan perangkat.
      builder: (context, child) {
        return MediaQuery.withClampedTextScaling(
          minScaleFactor: _minTextScale,
          maxScaleFactor: _maxTextScale,
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const SplashScreen(),
    );
  }

  // Tema dipisah dari build() agar kerangka MaterialApp tetap ringkas.
  ThemeData _buildTheme() {
    final ColorScheme craftColorScheme = ColorScheme.fromSeed(
      seedColor: primaryGreen,
      brightness: Brightness.light,
    ).copyWith(surface: pageBackground);

    return ThemeData(
      // Material 3 diaktifkan secara global.
      useMaterial3: true,
      colorScheme: craftColorScheme,
      scaffoldBackgroundColor: pageBackground,
      fontFamily: 'Roboto',

      // [M07] Kepadatan komponen menyesuaikan platform (ponsel/desktop/web).
      visualDensity: VisualDensity.adaptivePlatformDensity,

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

      // NavigationBar: navigasi bawah untuk layar sempit (ponsel).
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: Color(0xFFDDE9DF),
        elevation: 0,
        height: 72,
      ),

      // [M07] NavigationRail: navigasi samping untuk layar lebar (tablet).
      // Gayanya disamakan dengan NavigationBar agar konsisten.
      navigationRailTheme: const NavigationRailThemeData(
        backgroundColor: Colors.white,
        indicatorColor: Color(0xFFDDE9DF),
        elevation: 0,
      ),

      // SnackBar mengambang secara global (tidak menempel di tepi layar).
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),

      dividerTheme: const DividerThemeData(
        color: Color(0xFFE7E9E4),
        thickness: 1,
        space: 1,
      ),
    );
  }
}