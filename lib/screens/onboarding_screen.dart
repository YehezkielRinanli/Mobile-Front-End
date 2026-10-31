import 'package:flutter/material.dart';

import 'home_screen.dart';

// Model data sederhana agar semua halaman onboarding memakai komponen yang sama.
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

  // static const: data tidak berubah dan tidak dibuat ulang tiap build.
  static const List<OnboardingContent> contents = [
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
        // [M07] LayoutBuilder memberi lebar & tinggi area yang tersedia.
        child: LayoutBuilder(
          builder: (context, constraints) {
            // [M07] Orientasi dibaca dari MediaQuery (Layout Adaptation).
            final bool isLandscape =
                MediaQuery.orientationOf(context) == Orientation.landscape;

            // [M07] Di layar sangat lebar (tablet/desktop) konten dibatasi
            // agar tidak melebar berlebihan.
            final double contentMaxWidth =
                constraints.maxWidth > 1000 ? 1000 : constraints.maxWidth;

            // [M07] Padding horizontal ikut menyesuaikan lebar layar.
            final double horizontalPadding =
                constraints.maxWidth >= 600 ? 32 : 20;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: contentMaxWidth),
                // [M06] Column: PageView (Expanded) di atas, footer di bawah.
                child: Column(
                  children: [
                    Expanded(
                      // [M06] PageView = multi-child layout yang bisa digeser.
                      child: PageView.builder(
                        controller: _controller,
                        itemCount: contents.length,
                        onPageChanged: (index) =>
                            setState(() => _currentIndex = index),
                        itemBuilder: (context, index) {
                          final OnboardingContent item = contents[index];

                          return Padding(
                            padding: EdgeInsets.fromLTRB(
                              horizontalPadding,
                              16,
                              horizontalPadding,
                              8,
                            ),
                            // [M07] Layout Adaptation:
                            // Landscape -> Row (gambar kiri, teks kanan)
                            // Portrait  -> Column (gambar atas, teks bawah)
                            child: isLandscape
                                ? _buildLandscapePage(item, index, colors)
                                : _buildPortraitPage(item, index, colors),
                          );
                        },
                      ),
                    ),
                    // Footer: tombol + indikator halaman.
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding + 4,
                        8,
                        horizontalPadding + 4,
                        isLandscape ? 12 : 22,
                      ),
                      child: isLandscape
                          ? _buildLandscapeFooter(colors)
                          : _buildPortraitFooter(colors),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HALAMAN PORTRAIT: Column (atas-bawah)
  // ---------------------------------------------------------------------------
  Widget _buildPortraitPage(
    OnboardingContent item,
    int index,
    ColorScheme colors,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // [M06] Expanded flex 6: gambar mengisi sisa tinggi secara proporsional.
        Expanded(flex: 6, child: _buildImage(item, index, colors)),
        const SizedBox(height: 24),
        Text(item.title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 10),
        Text(
          item.description,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: colors.onSurfaceVariant),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // HALAMAN LANDSCAPE: Row (kiri-kanan)
  // ---------------------------------------------------------------------------
  Widget _buildLandscapePage(
    OnboardingContent item,
    int index,
    ColorScheme colors,
  ) {
    // [M06] Row: gambar dan teks berdampingan, masing-masing Expanded
    // agar membagi lebar secara proporsional.
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(flex: 5, child: _buildImage(item, index, colors)),
        const SizedBox(width: 24),
        Expanded(
          flex: 5,
          // Tinggi landscape terbatas -> teks dibungkus scroll + Center
          // agar tidak overflow namun tetap di tengah vertikal.
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item.description,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: colors.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // GAMBAR + BADGE NOMOR HALAMAN (dipakai ulang di portrait & landscape)
  // ---------------------------------------------------------------------------
  Widget _buildImage(OnboardingContent item, int index, ColorScheme colors) {
    // [M06] Stack: badge "1 / 3" di atas gambar.
    return Stack(
      children: [
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
        Positioned(
          top: 14,
          left: 14,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
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
    );
  }

  // ---------------------------------------------------------------------------
  // FOOTER
  // ---------------------------------------------------------------------------
  String get _buttonLabel =>
      _currentIndex == contents.length - 1 ? 'Mulai Sekarang' : 'Lanjut';

  // Portrait: tombol lebar penuh, indikator di bawahnya.
  Widget _buildPortraitFooter(ColorScheme colors) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          child: FilledButton(onPressed: _continue, child: Text(_buttonLabel)),
        ),
        const SizedBox(height: 22),
        _buildDotsRow(colors),
      ],
    );
  }

  // Landscape: satu baris hemat tinggi (indikator kiri, tombol kanan).
  Widget _buildLandscapeFooter(ColorScheme colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDotsRow(colors),
        FilledButton(onPressed: _continue, child: Text(_buttonLabel)),
      ],
    );
  }

  // [M06] Row + List.generate untuk indikator halaman.
  Widget _buildDotsRow(ColorScheme colors) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        contents.length,
        (index) => _buildDot(index, colors),
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