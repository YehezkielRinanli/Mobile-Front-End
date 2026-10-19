import 'package:flutter/material.dart';

import '../models/seller.dart';
import '../widgets/app_image.dart';
import 'explore_screen.dart';
import 'seller_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _recommendationsKey = GlobalKey();

  String _searchQuery = '';
  String _selectedCategory = 'Semua';
  int _selectedNavigationIndex = 0;
  final Set<String> _favoriteProducts = <String>{};

  static const List<MarketCategory> _categories = [
    MarketCategory(label: 'Tas & Aksesori', icon: Icons.shopping_bag_outlined),
    MarketCategory(label: 'Dekorasi', icon: Icons.weekend_outlined),
    MarketCategory(label: 'Anyaman', icon: Icons.grid_view_rounded),
    MarketCategory(label: 'Keramik', icon: Icons.dinner_dining_outlined),
    MarketCategory(label: 'Alat Rumah', icon: Icons.kitchen_outlined),
    MarketCategory(label: 'Pakaian', icon: Icons.checkroom_outlined),
  ];

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
      final bool matchesCategory = _selectedCategory == 'Semua' ||
          product.category == _selectedCategory;
      final String searchableText =
          '${product.name} ${product.category} ${product.artisan} ${product.location}'
              .toLowerCase();
      final bool matchesQuery = query.isEmpty || searchableText.contains(query);

      return matchesCategory && matchesQuery;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
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

  void _goToRecommendations() {
    final BuildContext? targetContext = _recommendationsKey.currentContext;
    if (targetContext == null) return;

    Scrollable.ensureVisible(
      targetContext,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      alignment: 0.05,
    );
  }

  void _selectCategory(String category) {
    setState(() => _selectedCategory = category);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _goToRecommendations();
    });
  }

  void _onNavigationSelected(int index) {
    if (index == _selectedNavigationIndex) {
      if (index == 0) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
      return;
    }

    setState(() => _selectedNavigationIndex = index);

    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ExploreScreen()),
        ).then((_) => setState(() => _selectedNavigationIndex = 0));
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const NotificationScreen()),
        ).then((_) => setState(() => _selectedNavigationIndex = 0));
        break;
      case 3:
        if (dummySellers.isNotEmpty) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SellerProfileScreen(seller: dummySellers.first),
            ),
          ).then((_) => setState(() => _selectedNavigationIndex = 0));
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildSearchField(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: HeroBannerCard(onShopNow: _goToRecommendations),
              ),
              const SizedBox(height: 24),
              SectionHeader(
                title: 'Kategori',
                subtitle: 'Temukan karya sesuai kebutuhanmu',
                actionLabel: 'Reset',
                onTapAction: () => _selectCategory('Semua'),
              ),
              _buildCategoryGrid(),
              const SizedBox(height: 18),
              _buildRecommendations(),
              const SizedBox(height: 28),
              _buildArtisanSection(),
              const SizedBox(height: 24),
              _buildImpactCard(),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedNavigationIndex,
        onDestinationSelected: _onNavigationSelected,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore_rounded),
            label: 'Jelajah',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_bag_outlined),
            selectedIcon: Icon(Icons.shopping_bag_rounded),
            label: 'Keranjang',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 16, 12),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.eco_rounded, color: colors.primary, size: 29),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PASAR KARYA LOKAL',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colors.onSurfaceVariant,
                        letterSpacing: 1.1,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  'CraftOrigin',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: colors.primary,
                        fontSize: 23,
                      ),
                ),
              ],
            ),
          ),
          IconButton.filledTonal(
            tooltip: 'Notifikasi',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const NotificationScreen()),
              );
            },
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: TextField(
        controller: _searchController,
        textInputAction: TextInputAction.search,
        onChanged: (value) => setState(() => _searchQuery = value),
        onSubmitted: (_) => _goToRecommendations(),
        decoration: InputDecoration(
          hintText: 'Cari produk, perajin, atau daerah...',
          prefixIcon: const Icon(Icons.search_rounded),
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

  Widget _buildCategoryGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.94,
        ),
        itemBuilder: (context, index) {
          final MarketCategory category = _categories[index];
          return CategoryItem(
            category: category,
            isSelected: _selectedCategory == category.label,
            onTap: () => _selectCategory(category.label),
          );
        },
      ),
    );
  }

  Widget _buildRecommendations() {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final List<CraftProduct> visibleProducts = _visibleProducts;
    final List<String> filters = ['Semua', ..._categories.map((item) => item.label)];

    return Column(
      key: _recommendationsKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Rekomendasi Untukmu',
          subtitle: 'Pilihan karya dengan sentuhan autentik',
          actionLabel: 'Lihat Semua',
          onTapAction: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ExploreScreen()),
            );
          },
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 8,
            runSpacing: 2,
            children: filters.map((filter) {
              final bool isSelected = _selectedCategory == filter;
              return ChoiceChip(
                label: Text(filter),
                selected: isSelected,
                onSelected: (_) => setState(() => _selectedCategory = filter),
                showCheckmark: false,
                labelStyle: TextStyle(
                  color: isSelected ? colors.onPrimary : colors.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
                selectedColor: colors.primary,
                backgroundColor: colors.surface,
                side: BorderSide(color: colors.outlineVariant),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 12),
        if (visibleProducts.isEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.search_off_rounded, size: 36, color: colors.outline),
                  const SizedBox(height: 8),
                  Text(
                    'Produk tidak ditemukan',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Coba kata kunci atau kategori lainnya.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          )
        else
          SizedBox(
            height: 292,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              scrollDirection: Axis.horizontal,
              itemCount: visibleProducts.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final CraftProduct product = visibleProducts[index];
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
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ExploreScreen()),
                    );
                  },
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildArtisanSection() {
    final List<Seller> sellersToDisplay = dummySellers.take(4).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Kenali Perajinnya',
          subtitle: 'Cerita di balik karya yang kamu pilih',
          actionLabel: 'Lihat Semua',
          onTapAction: () => _showMessage('Menampilkan perajin pilihan.'),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 116,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: sellersToDisplay.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final Seller seller = sellersToDisplay[index];
              return ArtisanCard(
                seller: seller,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SellerProfileScreen(seller: seller),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildImpactCard() {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        margin: EdgeInsets.zero,
        color: colors.primaryContainer,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colors.surface.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(Icons.diversity_3_rounded, color: colors.primary),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                      decoration: BoxDecoration(
                        color: colors.surface.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'SDG 8 · Pekerjaan Layak',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: colors.primary,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Belanja yang punya arti.',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: colors.onPrimaryContainer,
                          ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Kenali karya, hargai keterampilan, dan dukung peluang ekonomi bagi perajin lokal.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: colors.onPrimaryContainer.withValues(alpha: 0.85),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifikasi & Keranjang')),
      body: const Center(
        child: Text('Halaman Notifikasi / Keranjang'),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// DATA MODEL LOKAL KATEGORI & PRODUK
// -----------------------------------------------------------------------------

class MarketCategory {
  const MarketCategory({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

class CraftProduct {
  const CraftProduct({
    required this.name,
    required this.category,
    required this.price,
    required this.artisan,
    required this.location,
    required this.icon,
    required this.accentColor,
  });

  final String name;
  final String category;
  final String price;
  final String artisan;
  final String location;
  final IconData icon;
  final Color accentColor;
}

class HeroBannerCard extends StatelessWidget {
  const HeroBannerCard({super.key, required this.onShopNow});

  final VoidCallback onShopNow;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 190,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/banner_bg.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF718566), Color(0xFF263F30)],
                    ),
                  ),
                );
              },
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xD9000000), Color(0x66000000), Color(0x00000000)],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 16, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.45)),
                    ),
                    child: const Text(
                      'KARYA LOKAL, DAMPAK NYATA',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 9,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Produk Lokal\nRamah Lingkungan',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 23,
                          height: 1.15,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 12),
                  FilledButton.tonalIcon(
                    onPressed: onShopNow,
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: colors.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                      minimumSize: const Size(0, 40),
                    ),
                    icon: const Icon(Icons.shopping_bag_outlined, size: 17),
                    label: const Text('Belanja Sekarang'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.actionLabel,
    required this.onTapAction,
  });

  final String title;
  final String subtitle;
  final String actionLabel;
  final VoidCallback onTapAction;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 12, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onTapAction,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              minimumSize: const Size(0, 40),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(actionLabel, style: const TextStyle(fontSize: 12)),
                const SizedBox(width: 2),
                const Icon(Icons.chevron_right_rounded, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  final MarketCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: isSelected ? colors.primaryContainer : colors.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? colors.primary : colors.outlineVariant,
          width: isSelected ? 1.4 : 0.8,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 9),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 49,
                height: 49,
                decoration: BoxDecoration(
                  color: isSelected
                      ? colors.surface.withValues(alpha: 0.88)
                      : const Color(0xFFF1EFE8),
                  shape: BoxShape.circle,
                ),
                child: Icon(category.icon, size: 26, color: colors.primary),
              ),
              const SizedBox(height: 8),
              Text(
                category.label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.w700,
                      height: 1.15,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onFavoriteTap,
    required this.onTap,
  });

  final CraftProduct product;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: 184,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 1,
        shadowColor: colors.shadow.withValues(alpha: 0.08),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: colors.outlineVariant.withValues(alpha: 0.55)),
        ),
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.22,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ProductIllustration(product: product),
                    Positioned(
                      left: 9,
                      top: 9,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(
                          color: colors.surface.withValues(alpha: 0.94),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.eco_rounded, color: colors.primary, size: 12),
                            const SizedBox(width: 3),
                            Text(
                              'Pilihan lokal',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: colors.primary,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 9,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: IconButton.filledTonal(
                        tooltip: isFavorite ? 'Hapus dari favorit' : 'Tambah ke favorit',
                        onPressed: onFavoriteTap,
                        visualDensity: VisualDensity.compact,
                        style: IconButton.styleFrom(
                          backgroundColor: colors.surface.withValues(alpha: 0.92),
                          foregroundColor: isFavorite ? Colors.redAccent : colors.primary,
                        ),
                        icon: Icon(
                          isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 11),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.category.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontSize: 9,
                              letterSpacing: 0.5,
                              color: colors.onSurfaceVariant,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              height: 1.15,
                            ),
                      ),
                      const Spacer(),
                      Text(
                        '${product.artisan} · ${product.location}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colors.onSurfaceVariant,
                              fontSize: 10,
                            ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        product.price,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: colors.primary,
                              fontSize: 14,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductIllustration extends StatelessWidget {
  const ProductIllustration({super.key, required this.product});

  final CraftProduct product;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            product.accentColor.withValues(alpha: 0.13),
            product.accentColor.withValues(alpha: 0.36),
          ],
        ),
      ),
      child: Center(
        child: Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.55),
            shape: BoxShape.circle,
          ),
          child: Icon(product.icon, size: 48, color: product.accentColor),
        ),
      ),
    );
  }
}

class ArtisanCard extends StatelessWidget {
  const ArtisanCard({
    super.key,
    required this.seller,
    required this.onTap,
  });

  final Seller seller;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    final String location = seller.products.isNotEmpty
        ? seller.products.first.location
        : seller.location;

    return SizedBox(
      width: 244,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: colors.outlineVariant),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                SizedBox(
                  width: 54,
                  height: 54,
                  child: ClipOval(
                    child: AppImage(
                      path: seller.photo,
                      placeholderIcon: Icons.person,
                    ),
                  ),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        seller.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontSize: 14,
                            ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        seller.shopName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 13,
                            color: colors.primary,
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              location,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: colors.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: colors.outline),
              ],
            ),
          ),
        ),
      ),
    );
  }
}