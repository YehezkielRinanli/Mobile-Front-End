import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const CraftOriginApp());
}

class CraftOriginApp extends StatelessWidget {
  const CraftOriginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CraftOrigin',
      debugShowCheckedModeBanner: false, // Menghilangkan pita "DEBUG"
      theme: ThemeData(
        // Constraint warna utama (Hijau Gelap organik)
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2A5940)),
        useMaterial3: true,
        fontFamily: 'Roboto', // Bisa diganti jika nanti ada custom font
      ),
      home: const SplashScreen(),
    );
  }
}