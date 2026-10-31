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

    // Pindah ke onboarding setelah 3 detik.
    // `mounted` dicek agar context tidak dipakai setelah widget dibuang.
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryGreen = Theme.of(context).colorScheme.primary;

    return Scaffold(
      // [M07] LayoutBuilder memberi BoxConstraints (ruang yang benar-benar
      // tersedia), sehingga ukuran elemen dihitung dari layar, bukan angka tetap.
      body: LayoutBuilder(
        builder: (context, constraints) {
          // [M07] Sisi terpendek dipakai sebagai basis skala. Di landscape sisi
          // terpendek = tinggi, jadi logo/teks otomatis mengecil dan tidak overflow.
          final double base = constraints.biggest.shortestSide;

          // clamp() membatasi ukuran minimum & maksimum agar tetap proporsional
          // di ponsel kecil maupun tablet besar.
          final double logoSize = (base * 0.18).clamp(48.0, 110.0);
          final double titleSize = (base * 0.10).clamp(28.0, 56.0);
          final double subtitleSize = (base * 0.04).clamp(14.0, 22.0);
          final double gap = (base * 0.025).clamp(8.0, 20.0);

          // [M07] MediaQuery untuk metrik layar: padding bawah (gesture bar/notch)
          // agar indikator loading tidak tertutup area sistem.
          final double bottomInset = MediaQuery.paddingOf(context).bottom;

          // [M07] Offset atas dihitung dari tinggi layar (12%), bukan angka tetap 64,
          // sehingga posisi logo tetap "sedikit ke atas" di ponsel, tablet, dan landscape.
          final double topOffset = (constraints.maxHeight * 0.12).clamp(
            24.0,
            110.0,
          );

          // [M06] Stack = multi-child layout bertumpuk:
          // layer 1 gambar, layer 2 gradient, layer 3 konten tengah, layer 4 loading.
          return Stack(
            fit: StackFit.expand,
            children: [
              // Layer 1: gambar latar penuh layar.
              Image.asset(
                'assets/images/splash_bg.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback bila aset belum dipasang.
                  return Container(color: primaryGreen);
                },
              ),

              // Layer 2: gradient agar teks putih tetap kontras.
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

              // Layer 3: logo + judul di area atas (posisi sama seperti desain asli).
              // [M06] SafeArea + Align(topCenter) + Column(mainAxisSize.min).
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24, topOffset, 24, 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.eco_rounded,
                          size: logoSize,
                          color: Colors.white,
                        ),
                        SizedBox(height: gap),
                        Text(
                          'CraftOrigin',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                                fontSize: titleSize,
                                letterSpacing: 1.1,
                              ),
                        ),
                        SizedBox(height: gap * 0.6),
                        Text(
                          'Dari Tangan Lokal, Untuk Dunia.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Colors.white.withOpacity(0.92),
                                fontSize: subtitleSize,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Layer 4: indikator loading + tagline di bagian bawah.
              // [M06] Positioned(left/right/bottom) mengunci posisi relatif
              // terhadap tepi Stack, ditambah bottomInset dari MediaQuery.
              Positioned(
                left: 24,
                right: 24,
                bottom: bottomInset + 28,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.white.withOpacity(0.9),
                        backgroundColor: Colors.white24,
                      ),
                    ),
                    SizedBox(height: gap),
                    const Text(
                      'Karya bermakna. Dampak berkelanjutan.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
