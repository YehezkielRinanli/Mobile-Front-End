import 'package:flutter/material.dart';

import 'home_screen.dart';

// Model data sederhana agar setiap halaman onboarding menggunakan komponen sama.
class OnboardingContent {
  const OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });

  final String image;
  final String title;
  final String description;
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;
  late final PageController _controller;

  // Konten masih lokal dan dapat ditambah tanpa mengubah struktur UI.
  final List<OnboardingContent> contents = const [
    OnboardingContent(
      image: 'assets/images/onboarding_1.jpg',
      title: 'Dukung Perajin Lokal',
      description:
          'Temukan karya autentik dari perajin daerah dan bantu mereka memperoleh apresiasi yang layak atas setiap karya.',
    ),
    OnboardingContent(
      image: 'assets/images/onboarding_2.jpg',
      title: 'Pilih Produk Ramah Lingkungan',
      description:
          'Pilih kerajinan dengan inspirasi dari bahan alami dan proses yang lebih bertanggung jawab terhadap bumi.',
    ),
    OnboardingContent(
      image: 'assets/images/onboarding_3.jpg',
      title: 'Jadi Bagian dari Perubahan',
      description:
          'Setiap pilihan yang bijak ikut mendukung pekerjaan layak, pertumbuhan ekonomi, dan keberlanjutan komunitas.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _continue() {
    if (_currentIndex < contents.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeInOut,
      );
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              // PageView adalah multi-child layout untuk beberapa halaman.
              child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemBuilder: (context, index) {
                  final OnboardingContent item = contents[index];

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Stack(
                            children: [
                              // ClipRRect membuat gambar memiliki sudut konsisten.
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(28),
                                  child: Image.asset(
                                    item.image,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: colors.primaryContainer,
                                        child: Center(
                                          child: Icon(
                                            Icons.image_outlined,
                                            size: 64,
                                            color: colors.primary,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              // Stack + Positioned untuk nomor halaman di atas foto.
                              Positioned(
                                top: 14,
                                left: 14,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.92),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    '${index + 1} / ${contents.length}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(color: colors.primary),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          item.title,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item.description,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: colors.onSurfaceVariant,
                              ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Footer dibuat terpisah agar tombol tetap berada di bagian bawah.
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 22),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _continue,
                      child: Text(
                        _currentIndex == contents.length - 1
                            ? 'Mulai Sekarang'
                            : 'Lanjut',
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      contents.length,
                      (index) => _buildDot(index, colors),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(int index, ColorScheme colors) {
    final bool isActive = index == _currentIndex;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeInOut,
      width: isActive ? 25 : 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isActive ? colors.primary : colors.outlineVariant,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
