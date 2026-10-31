import 'package:flutter/material.dart';

import 'explore_screen.dart';

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

  // [M07] Breakpoint tersentral agar semua keputusan layout memakai angka sama.
  static const double _tabletBreakpoint = 600;
  static const double _wideBreakpoint = 900;
  static const double _railBreakpoint = 840;
  static const double _contentMaxWidth = 1200;

  static const List<_NavItem> _navItems = [
    _NavItem('Home', Icons.home_outlined, Icons.home_rounded),
    _NavItem('Jelajah', Icons.explore_outlined, Icons.explore_rounded),
    _NavItem('Keranjang', Icons.shopping_bag_outlined, Icons.shopping_bag_rounded),
    _NavItem('Profil', Icons.person_outline_rounded, Icons.person_rounded),
  ];

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

  static const List<ArtisanProfile> _artisans = [
    ArtisanProfile(
      name: 'Ibu Siti',
      specialty: 'Anyaman rotan',
      location: 'Bali',
      initials: 'IS',
      avatarColor: Color(0xFFE9D5BE),
    ),
    ArtisanProfile(
      name: 'Tenun Lestari',
      specialty: 'Tenun tradisional',
      location: 'Sumba',
      initials: 'TL',
      avatarColor: Color(0xFFD5E4D6),
    ),
    ArtisanProfile(
      name: 'Studio Akar',
      specialty: 'Dekorasi alami',
      location: 'Bandung',
      initials: 'SA',
      avatarColor: Color(0xFFE9DCC4),
    ),
  ];

  List<CraftProduct> get _visibleProducts {
    final String query = _searchQuery.trim().toLowerCase();

    return _products.where((product) {
      final bool matchesCategory =
          _selectedCategory == 'Semua' || product.category == _selectedCategory;
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
    if (index == 0) {
      setState(() => _selectedNavigationIndex = 0);
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
      return;
    }

    if (index == 1) {
      setState(() => _selectedNavigationIndex = 1);
      return;
    }

    // Keranjang dan Profil belum dibuat.
    _showMessage(
      'Halaman ${_navItems[index].label} akan dikembangkan berikutnya.',
    );
  }

  // ---------------------------------------------------------------------------
  // [M07] Helper Screen Metrics
  // ---------------------------------------------------------------------------

  // Jumlah kolom grid kategori mengikuti lebar area yang tersedia.
  int _categoryColumns(double width) {
    if (width < _tabletBreakpoint) return 3; // ponsel
    if (width < _wideBreakpoint) return 4; // tablet portrait
    if (width < 1200) return 5; // tablet landscape
    return 6; // layar sangat lebar
  }

  // Lebar kartu produk/perajin bertambah di layar yang lebih besar.
  double _productCardWidth(double width) {
    if (width < _tabletBreakpoint) return 184;
    if (width < _wideBreakpoint) return 200;
    return 220;
  }

  double _artisanCardWidth(double width) {
    if (width < _tabletBreakpoint) return 244;
    return 290;
  }

  // Skala teks sistem (pengaturan aksesibilitas), dibatasi 1.0 - 1.4 agar
  // tinggi kontainer ikut membesar tanpa merusak layout.
  double _textScale(BuildContext context) {
    return MediaQuery.textScalerOf(context).scale(1.0).clamp(1.0, 1.4);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    // [M07] LayoutBuilder level halaman: layar lebar memakai NavigationRail
    // (samping), layar sempit memakai NavigationBar (bawah).
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool useRail = constraints.maxWidth >= _railBreakpoint;

        final Widget body = IndexedStack(
          index: _selectedNavigationIndex,
          children: [
            _buildHomeContent(), // Index 0
            const ExploreScreen(), // Index 1
            const Center(child: Text('Keranjang - Segera Hadir')), // Index 2
            const Center(child: Text('Profil - Segera Hadir')), // Index 3
          ],
        );

        return Scaffold(
          backgroundColor: colors.surface,
          body: SafeArea(
            // [M06] Row: rail di kiri, konten di kanan (Expanded).
            child: useRail
                ? Row(
                    children: [
                      NavigationRail(
                        selectedIndex: _selectedNavigationIndex,
                        onDestinationSelected: _onNavigationSelected,
                        labelType: NavigationRailLabelType.all,
                        backgroundColor: Colors.white,
                        indicatorColor: const Color(0xFFDDE9DF),
                        destinations: [
                          for (final _NavItem item in _navItems)
                            NavigationRailDestination(
                              icon: Icon(item.icon),
                              selectedIcon: Icon(item.selectedIcon),
                              label: Text(item.label),
                            ),
                        ],
                      ),
                      const VerticalDivider(width: 1),
                      Expanded(child: body),
                    ],
                  )
                : body,
          ),
          bottomNavigationBar: useRail
              ? null
              : NavigationBar(
                  selectedIndex: _selectedNavigationIndex,
                  onDestinationSelected: _onNavigationSelected,
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                  destinations: [
                    for (final _NavItem item in _navItems)
                      NavigationDestination(
                        icon: Icon(item.icon),
                        selectedIcon: Icon(item.selectedIcon),
                        label: item.label,
                      ),
                  ],
                ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // HALAMAN HOME
  // ---------------------------------------------------------------------------
  Widget _buildHomeContent() {
    // [M07] LayoutBuilder: constraints.maxWidth = lebar area konten sebenarnya
    // (sudah dikurangi NavigationRail bila ada).
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;

        // Konten dibatasi lebar maksimum, lalu diletakkan di tengah.
        final double contentWidth =
            width > _contentMaxWidth ? _contentMaxWidth : width;

        return SingleChildScrollView(
          controller: _scrollController,
          child: Center(
            child: SizedBox(
              width: contentWidth,
              // [M06] Column: susunan vertikal utama halaman.
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
                  _buildCategoryGrid(contentWidth),
                  const SizedBox(height: 18),
                  _buildRecommendations(contentWidth),
                  const SizedBox(height: 28),
                  _buildArtisanSection(contentWidth),
                  const SizedBox(height: 24),
                  _buildImpactCard(),
                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // HEADER: Row + Expanded + Container sebagai komposisi multi-child.
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colors.onSurfaceVariant,
                        letterSpacing: 1.1,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  'CraftOrigin',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
            onPressed: () =>
                _showMessage('Fitur notifikasi akan dikembangkan berikutnya.'),
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

  // [M06] GridView + [M07] jumlah kolom dinamis dari lebar layar.
  Widget _buildCategoryGrid(double contentWidth) {
    final int columns = _categoryColumns(contentWidth);
    final double textScale = _textScale(context);

    // Tinggi sel dibuat tetap (mainAxisExtent), bukan childAspectRatio, supaya
    // tinggi tidak membengkak saat kolom bertambah di layar lebar. Tambahan
    // tinggi mengikuti skala teks agar label 2 baris tidak overflow.
    final double cellHeight = 112 + (textScale - 1) * 40;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          mainAxisExtent: cellHeight,
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

  Widget _buildRecommendations(double contentWidth) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final List<CraftProduct> visibleProducts = _visibleProducts;
    final List<String> filters = [
      'Semua',
      ..._categories.map((item) => item.label),
    ];

    // [M07] Ukuran kartu & tinggi list dihitung dari metrik layar.
    final double cardWidth = _productCardWidth(contentWidth);
    final double textScale = _textScale(context);
    // Tinggi = tinggi gambar (rasio 1.22) + area teks yang ikut skala teks.
    final double listHeight = (cardWidth / 1.22) + (140 * textScale);

    return Column(
      key: _recommendationsKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Rekomendasi Untukmu',
          subtitle: 'Pilihan karya dengan sentuhan autentik',
          actionLabel: 'Lihat Semua',
          onTapAction: () {
            setState(() => _selectedCategory = 'Semua');
            _showMessage(
              'Menampilkan semua produk yang tersedia di contoh katalog.',
            );
          },
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          // [M06] Wrap: chip pindah baris otomatis sesuai lebar layar.
          child: Wrap(
            spacing: 8,
            runSpacing: 6,
            children: filters.map((filter) {
              final bool isSelected = _selectedCategory == filter;
              return ConstrainedBox(
                // [M07] Chip tidak boleh lebih lebar dari area konten,
                // sehingga label panjang di-ellipsis, bukan overflow.
                constraints: BoxConstraints(maxWidth: contentWidth - 32),
                child: ChoiceChip(
                  label: Text(
                    filter,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  selected: isSelected,
                  onSelected: (_) => setState(() => _selectedCategory = filter),
                  showCheckmark: false,
                  labelStyle: TextStyle(
                    color:
                        isSelected ? colors.onPrimary : colors.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                  selectedColor: colors.primary,
                  backgroundColor: colors.surface,
                  side: BorderSide(color: colors.outlineVariant),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
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
                  Icon(Icons.search_off_rounded,
                      size: 36, color: colors.outline),
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
            height: listHeight,
            // [M06] ListView horizontal untuk kartu produk yang bisa digeser.
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              scrollDirection: Axis.horizontal,
              itemCount: visibleProducts.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final CraftProduct product = visibleProducts[index];
                return ProductCard(
                  width: cardWidth,
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
      ],
    );
  }

  Widget _buildArtisanSection(double contentWidth) {
    final double textScale = _textScale(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Kenali Perajinnya',
          subtitle: 'Cerita di balik karya yang kamu pilih',
          actionLabel: 'Tentang Kami',
          onTapAction: () =>
              _showMessage('Profil lengkap perajin akan tersedia berikutnya.'),
        ),
        const SizedBox(height: 8),
        SizedBox(
          // [M07] Tinggi mengikuti skala teks agar isi kartu tidak terpotong.
          height: 116 * textScale,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: _artisans.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final ArtisanProfile artisan = _artisans[index];
              return ArtisanCard(
                width: _artisanCardWidth(contentWidth),
                artisan: artisan,
                onTap: () => _showMessage(
                  'Profil ${artisan.name} akan tersedia pada pengembangan berikutnya.',
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Card informasi yang menghubungkan CraftOrigin dengan SDG 8.
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
                  color: colors.surface.withOpacity(0.85),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: colors.surface.withOpacity(0.8),
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
                            color: colors.onPrimaryContainer.withOpacity(0.85),
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

// Data item navigasi, dipakai bersama oleh NavigationBar dan NavigationRail.
class _NavItem {
  const _NavItem(this.label, this.icon, this.selectedIcon);

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

// -----------------------------------------------------------------------------
// DATA MODEL LOKAL
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

class ArtisanProfile {
  const ArtisanProfile({
    required this.name,
    required this.specialty,
    required this.location,
    required this.initials,
    required this.avatarColor,
  });

  final String name;
  final String specialty;
  final String location;
  final String initials;
  final Color avatarColor;
}

// -----------------------------------------------------------------------------
// REUSABLE UI COMPONENTS
// -----------------------------------------------------------------------------

class HeroBannerCard extends StatelessWidget {
  const HeroBannerCard({super.key, required this.onShopNow});

  final VoidCallback onShopNow;

  // [M07] Batas tinggi banner. Di layar besar tinggi tidak melewati 300.
  static const BoxConstraints _heightLimits = BoxConstraints(
    minHeight: 190,
    maxHeight: 300,
  );

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;

        // [M07] Tinggi ideal = lebar / 2.1, lalu dipaksa masuk ke batas
        // BoxConstraints (min 190, max 300) lewat constrainHeight().
        final double height = _heightLimits.constrainHeight(width / 2.1);

        // Ukuran judul ikut lebar banner, dibatasi 22 - 36.
        final double titleSize = (width * 0.055).clamp(22.0, 36.0);

        return SizedBox(
          height: height,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            // [M06] Stack: gambar, gradient, lalu konten teks di atasnya.
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
                      colors: [
                        Color(0xD9000000),
                        Color(0x66000000),
                        Color(0x00000000),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 16, 18),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    // FittedBox(scaleDown): bila teks sistem membesar dan isi
                    // lebih tinggi dari banner, isi diperkecil, bukan overflow.
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.18),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.45),
                              ),
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
                            style:
                                Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: Colors.white,
                                      fontSize: titleSize,
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 9,
                              ),
                              minimumSize: const Size(0, 40),
                            ),
                            icon: const Icon(
                              Icons.shopping_bag_outlined,
                              size: 17,
                            ),
                            label: const Text('Belanja Sekarang'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
                      ? colors.surface.withOpacity(0.88)
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
    this.width = 184,
  });

  final CraftProduct product;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final VoidCallback onTap;

  // Lebar bisa diatur dari luar (ListView di Home). Di dalam GridView
  // (ExploreScreen) lebar otomatis mengikuti sel grid, karena constraint
  // dari grid bersifat tight dan menimpa nilai ini.
  final double? width;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: width,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 1,
        shadowColor: colors.shadow.withOpacity(0.08),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: colors.outlineVariant.withOpacity(0.55)),
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: colors.surface.withOpacity(0.94),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.eco_rounded,
                                color: colors.primary, size: 12),
                            const SizedBox(width: 3),
                            Text(
                              'Pilihan lokal',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
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
                        tooltip: isFavorite
                            ? 'Hapus dari favorit'
                            : 'Tambah ke favorit',
                        onPressed: onFavoriteTap,
                        visualDensity: VisualDensity.compact,
                        style: IconButton.styleFrom(
                          backgroundColor: colors.surface.withOpacity(0.92),
                          foregroundColor:
                              isFavorite ? Colors.redAccent : colors.primary,
                        ),
                        icon: Icon(
                          isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
            product.accentColor.withOpacity(0.13),
            product.accentColor.withOpacity(0.36),
          ],
        ),
      ),
      child: Center(
        child: Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.55),
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
    required this.artisan,
    required this.onTap,
    this.width = 244,
  });

  final ArtisanProfile artisan;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: width,
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
                CircleAvatar(
                  radius: 27,
                  backgroundColor: artisan.avatarColor,
                  child: Text(
                    artisan.initials,
                    style: TextStyle(
                      color: colors.primary,
                      fontWeight: FontWeight.w800,
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
                        artisan.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontSize: 14,
                                ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        artisan.specialty,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              size: 13, color: colors.primary),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              artisan.location,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
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