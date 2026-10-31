import 'package:flutter/material.dart';

import 'home_screen.dart'; // CraftProduct, ProductCard

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final Set<String> _favoriteProducts = <String>{};

  // [M07] Breakpoint dan batas lebar konten dipusatkan di satu tempat.
  static const double _tabletBreakpoint = 600;
  static const double _contentMaxWidth = 1200;

  // Konstanta grid, dipakai juga untuk menghitung rasio kartu.
  static const double _gridHorizontalPadding = 16;
  static const double _gridSpacing = 12;

  // Rasio gambar di ProductCard (harus sama dengan AspectRatio di ProductCard).
  static const double _imageAspectRatio = 1.22;

  // Tinggi area teks ProductCard (kategori, nama 2 baris, perajin, harga).
  static const double _cardTextAreaHeight = 124;

  static const List<CraftProduct> _products = [
    CraftProduct(
      name: 'Tas Anyaman Rotan',
      category: 'Tas & Aksesori',
      price: 'Rp150.000',
      artisan: 'Ibu Siti',
      location: 'Bali',
      icon: Icons.shopping_bag_outlined,
      accentColor: Color(0xFF956B43),
    ),
    CraftProduct(
      name: 'Keranjang Serbaguna',
      category: 'Anyaman',
      price: 'Rp85.000',
      artisan: 'Kelompok Rattanara',
      location: 'Yogyakarta',
      icon: Icons.shopping_basket_outlined,
      accentColor: Color(0xFF7C8054),
    ),
    CraftProduct(
      name: 'Vas Keramik Bumi',
      category: 'Keramik',
      price: 'Rp120.000',
      artisan: 'Pak Wayan',
      location: 'Lombok',
      icon: Icons.local_florist_outlined,
      accentColor: Color(0xFFAD7057),
    ),
    CraftProduct(
      name: 'Lampu Meja Rotan',
      category: 'Dekorasi',
      price: 'Rp210.000',
      artisan: 'Studio Akar',
      location: 'Bandung',
      icon: Icons.lightbulb_outline_rounded,
      accentColor: Color(0xFFB18A42),
    ),
    CraftProduct(
      name: 'Syal Tenun Alami',
      category: 'Pakaian',
      price: 'Rp95.000',
      artisan: 'Tenun Lestari',
      location: 'Sumba',
      icon: Icons.checkroom_outlined,
      accentColor: Color(0xFF527B77),
    ),
    CraftProduct(
      name: 'Kotak Bambu Minimalis',
      category: 'Alat Rumah',
      price: 'Rp68.000',
      artisan: 'Bambu Kita',
      location: 'Magelang',
      icon: Icons.inventory_2_outlined,
      accentColor: Color(0xFF778A58),
    ),
  ];

  List<CraftProduct> get _visibleProducts {
    final String query = _searchQuery.trim().toLowerCase();

    return _products.where((product) {
      final String searchableText =
          '${product.name} ${product.category} ${product.artisan} ${product.location}'
              .toLowerCase();
      return query.isEmpty || searchableText.contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
        ),
      );
  }

  // ---------------------------------------------------------------------------
  // [M07] Helper Screen Metrics
  // ---------------------------------------------------------------------------

  // Ponsel (< 600) = 2 kolom, tablet / landscape lebar (>= 600) = 4 kolom.
  int _columnsFor(double screenWidth) {
    return screenWidth < _tabletBreakpoint ? 2 : 4;
  }

  // childAspectRatio dihitung, bukan angka tetap (sebelumnya 0.68):
  // 1. cari lebar 1 sel dari lebar grid dan jumlah kolom,
  // 2. tinggi sel = tinggi gambar (lebar / 1.22) + area teks yang ikut skala teks,
  // 3. rasio = lebar / tinggi.
  // Hasilnya kartu tetap proporsional dan teks tidak overflow di semua ukuran.
  double _aspectRatioFor({
    required double gridWidth,
    required int columns,
    required double textScale,
  }) {
    final double usableWidth = gridWidth - (_gridHorizontalPadding * 2);
    final double cellWidth =
        (usableWidth - (_gridSpacing * (columns - 1))) / columns;
    final double cellHeight =
        (cellWidth / _imageAspectRatio) + (_cardTextAreaHeight * textScale);

    return cellWidth / cellHeight;
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final List<CraftProduct> visibleProducts = _visibleProducts;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        scrolledUnderElevation: 0,
        title: Text(
          'Jelajah Karya',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w700,
              ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(68),
          // Search field dibatasi lebarnya agar tidak terlalu panjang di tablet.
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _contentMaxWidth),
              child: _buildSearchField(),
            ),
          ),
        ),
      ),
      body: visibleProducts.isEmpty
          ? _buildEmptyState(colors)
          : _buildProductGrid(visibleProducts),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: TextField(
        controller: _searchController,
        textInputAction: TextInputAction.search,
        onChanged: (value) => setState(() => _searchQuery = value),
        decoration: InputDecoration(
          hintText: 'Cari produk, perajin, atau daerah...',
          prefixIcon: const Icon(Icons.search_rounded),
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          fillColor: Theme.of(context)
              .colorScheme
              .surfaceContainerHighest
              .withOpacity(0.3),
          filled: true,
          suffixIcon: _searchQuery.isEmpty
              ? null
              : IconButton(
                  tooltip: 'Hapus pencarian',
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                ),
        ),
      ),
    );
  }

  // State kosong dibungkus scroll agar tidak overflow saat landscape
  // (tinggi layar kecil) atau saat keyboard terbuka.
  Widget _buildEmptyState(ColorScheme colors) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off_rounded, size: 48, color: colors.outline),
            const SizedBox(height: 16),
            Text(
              'Produk tidak ditemukan',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Coba kata kunci pencarian lainnya.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  // [M06] GridView.builder + [M07] kolom & rasio dinamis dari MediaQuery.
  Widget _buildProductGrid(List<CraftProduct> visibleProducts) {
    // [M07] MediaQuery.sizeOf hanya rebuild saat ukuran berubah (rotasi, resize),
    // lebih efisien daripada MediaQuery.of(context).size.
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double textScale = MediaQuery.textScalerOf(context)
        .scale(1.0)
        .clamp(1.0, 1.4)
        .toDouble();

    final int columns = _columnsFor(screenWidth);

    // Lebar grid sebenarnya tidak melebihi batas maksimum konten.
    final double gridWidth =
        screenWidth > _contentMaxWidth ? _contentMaxWidth : screenWidth;

    final double aspectRatio = _aspectRatioFor(
      gridWidth: gridWidth,
      columns: columns,
      textScale: textScale,
    );

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        // [M07] BoxConstraints: grid tidak melebar tanpa batas di layar besar.
        constraints: const BoxConstraints(maxWidth: _contentMaxWidth),
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: _gridHorizontalPadding,
            vertical: 8,
          ),
          itemCount: visibleProducts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: _gridSpacing,
            mainAxisSpacing: _gridSpacing,
            childAspectRatio: aspectRatio,
          ),
          itemBuilder: (context, index) {
            final CraftProduct product = visibleProducts[index];

            // ProductCard dipakai ulang dari HomeScreen. Lebarnya otomatis
            // mengikuti sel grid (constraint tight dari grid).
            return ProductCard(
              product: product,
              isFavorite: _favoriteProducts.contains(product.name),
              onFavoriteTap: () {
                setState(() {
                  if (!_favoriteProducts.add(product.name)) {
                    _favoriteProducts.remove(product.name);
                  }
                });
              },
              onTap: () => _showMessage(
                'Detail ${product.name} akan tersedia pada pengembangan berikutnya.',
              ),
            );
          },
        ),
      ),
    );
  }
}