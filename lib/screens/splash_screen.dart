import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Berpindah ke OnboardingScreen setelah 3 detik
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Gambar latar belakang
          Image.asset(
            'assets/images/splash_bg.png',
            fit: BoxFit.cover,
          ),
          // Overlay gelap tipis agar teks kontras
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          // Rich Controls: Logo & Teks diposisikan di tengah atas
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 80, 24, 0), // Padding atas 80 agar aman dari status bar & pas di atas
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Posisi di atas
              crossAxisAlignment: CrossAxisAlignment.center, // Rata tengah secara horizontal
              children: [
                const Icon(
                  Icons.eco,
                  size: 64,
                  color: Colors.white,
                ),
                const SizedBox(height: 16),
                const Text(
                  'CraftOrigin',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Dari Tangan Lokal, Untuk Dunia.',
                  textAlign: TextAlign.center, // Membuat teks subjudul rata tengah
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}