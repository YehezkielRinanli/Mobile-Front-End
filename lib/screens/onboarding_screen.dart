import 'package:flutter/material.dart';

import 'home_screen.dart';

// 1. Custom Reusability: Model data untuk menyimpan konten setiap halaman
class OnboardingContent {
  final String image;
  final String title;
  final String description;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;
  late PageController _controller;

  // 2. Data konten yang merujuk pada desain CraftOrigin
  final List<OnboardingContent> contents = [
    OnboardingContent(
      image: 'assets/images/onboarding_1.jpg',
      title: 'Dukung Perajin Lokal',
      description: 'Beli langsung dari tangan perajin di daerah pelosok, tanpa perantara yang eksploitatif.',
    ),
    OnboardingContent(
      image: 'assets/images/onboarding_2.jpg',
      title: 'Pilih Produk Ramah Lingkungan',
      description: 'Dari bahan alami, proses yang bertanggung jawab, untuk bumi yang lebih baik.',
    ),
    OnboardingContent(
      image: 'assets/images/onboarding_3.jpg',
      title: 'Jadi Bagian dari Perubahan',
      description: 'Setiap pembelianmu membantu meningkatkan kesejahteraan perajin dan menjaga lingkungan.',
    ),
  ];

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 3. Basic UI Layout: PageView memakan ruang atas
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Gambar dengan rasio yang disesuaikan

                      // Bungkus Stack dengan Padding agar ada jarak di kiri, kanan, dan atas
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.55,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(contents[i].image),
                                  fit: BoxFit.cover,
                                ),
                                // Ubah menjadi circular di semua sisi
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            // Sesuaikan posisi indikator halaman agar tidak menempel di pojok
                            Positioned(
                              top: 16,
                              left: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  '${i + 1}/${contents.length}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      // 4. Text & Rich Controls: Tipografi judul dan deskripsi
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          contents[i].title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E3A2B),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          contents[i].description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // Bagian Tombol dan Navigasi Dots di bawah
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentIndex == contents.length - 1) {
                          // Navigasi ke halaman Home dan ganti layar saat ini (tidak bisa di-back)
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        } else {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2A5940),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        _currentIndex == contents.length - 1
                            ? 'Mulai Sekarang'
                            : 'Lanjut',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Custom Reusability: Indikator titik (Dots)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      contents.length,
                      (index) => buildDot(index, context),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi pembentuk visual dot indicator
  Widget buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 8,
      width: _currentIndex == index ? 24 : 8,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: _currentIndex == index
            ? const Color(0xFF2A5940)
            : Colors.grey.shade300,
      ),
    );
  }
}
