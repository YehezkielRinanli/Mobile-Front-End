import 'package:flutter/material.dart';
import 'home_screen.dart';
// Catatan: Model CraftProduct, ProductCard, dan ProductIllustration 
// diasumsikan sudah bisa diakses (misalnya di-import dari home_screen.dart 
// atau file terpisah). Jika belum, Anda bisa menyalin class tersebut kemari.

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final Set<String> _favoriteProducts = <String>{};

  // Menggunakan data produk yang sama persis dengan HomeScreen
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

  // Logika pencarian yang sama, tanpa filter kategori
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
          child: _buildSearchField(),
        ),
      ),
      body: visibleProducts.isEmpty
          ? _buildEmptyState(colors)
          : _buildProductGrid(visibleProducts),
    );
  }

  // Menggunakan UI TextField pencarian persis seperti di HomeScreen
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
          fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
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

  // Menampilkan state "Tidak ditemukan" persis seperti di HomeScreen
  Widget _buildEmptyState(ColorScheme colors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }

  // Menggunakan GridView untuk menampilkan ProductCard
  Widget _buildProductGrid(List<CraftProduct> visibleProducts) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: visibleProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,           // 2 kolom untuk tampilan Jelajah
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.68,      // Rasio tinggi-lebar agar card proporsional
      ),
      itemBuilder: (context, index) {
        final CraftProduct product = visibleProducts[index];
        // Menggunakan kembali ProductCard dari HomeScreen
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
    );
  }
}