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

    // Pastikan widget masih terpasang sebelum menggunakan context.
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => const OnboardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryGreen = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Single-child/layout: Image menjadi latar penuh layar.
          Image.asset(
            'assets/images/splash_bg.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // Fallback agar layout tetap dapat diuji jika aset belum dipasang.
              return Container(color: primaryGreen);
            },
          ),
          // Overlay gradient menambah kontras teks pada gambar latar.
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x66000000),
                  Color(0x22000000),
                  Color(0x99000000),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 64, 24, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.eco_rounded, size: 66, color: Colors.white),
                    const SizedBox(height: 14),
                    Text(
                      'CraftOrigin',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontSize: 40,
                            letterSpacing: 1.1,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Dari Tangan Lokal, Untuk Dunia.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white.withOpacity(0.92),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Identitas singkat aplikasi ditempatkan di bawah sebagai pelengkap.
          const Positioned(
            left: 24,
            right: 24,
            bottom: 34,
            child: Text(
              'Karya bermakna. Dampak berkelanjutan.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
