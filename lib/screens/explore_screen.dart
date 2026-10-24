import 'package:flutter/material.dart';

import '../data/product_data.dart';
import '../data/seller_bridge.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';
import '../widgets/product_grid.dart';
import '../widgets/product_grid_card.dart';
import 'product_detail_screen.dart';

const Color _searchFill = Color(0xFFF0F2EE);

enum _PriceFilter {
  all('Semua harga'),
  under100('Di bawah Rp 100.000'),
  mid('Rp 100.000 - Rp 300.000'),
  over300('Di atas Rp 300.000');

  final String label;
  const _PriceFilter(this.label);

  bool matches(int price) {
    switch (this) {
      case _PriceFilter.all:
        return true;
      case _PriceFilter.under100:
        return price < 100000;
      case _PriceFilter.mid:
        return price >= 100000 && price <= 300000;
      case _PriceFilter.over300:
        return price > 300000;
    }
  }
}

enum _SortOption {
  relevance('Paling sesuai'),
  cheapest('Harga terendah'),
  priciest('Harga tertinggi'),
  topRated('Rating tertinggi');

  final String label;
  const _SortOption(this.label);
}

/// Halaman Explore / Products: pencarian, filter, dan grid produk.
///
/// Dari Home (tab Jelajah atau item kategori):
/// Navigator.push(context, MaterialPageRoute(
///   builder: (_) => ExploreScreen(initialCategory: ProductCategory.anyaman),
/// ));
class ExploreScreen extends StatefulWidget {
  final ProductCategory? initialCategory;

  const ExploreScreen({super.key, this.initialCategory});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  static const String _allCategories = 'all';

  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  ProductCategory? _category;
  _PriceFilter _price = _PriceFilter.all;
  _SortOption _sort = _SortOption.relevance;

  @override
  void initState() {
    super.initState();
    _category = widget.initialCategory;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool _matchesQuery(Product p, String q) {
    if (q.isEmpty) return true;
    final seller = registeredSellerFor(p.sellerId);
    final shopName = seller?.shopName.toLowerCase() ?? '';
    final sellerName = (seller?.name ?? p.sellerName).toLowerCase();

    return p.name.toLowerCase().contains(q) ||
        p.category.label.toLowerCase().contains(q) ||
        p.location.toLowerCase().contains(q) ||
        sellerName.contains(q) ||
        shopName.contains(q);
  }

  List<Product> get _results {
    final q = _query.trim().toLowerCase();

    final list = sampleProducts.where((p) {
      if (_category != null && p.category != _category) return false;
      if (!_price.matches(p.price)) return false;
      return _matchesQuery(p, q);
    }).toList();

    switch (_sort) {
      case _SortOption.relevance:
        break;
      case _SortOption.cheapest:
        list.sort((a, b) => a.price.compareTo(b.price));
        break;
      case _SortOption.priciest:
        list.sort((a, b) => b.price.compareTo(a.price));
        break;
      case _SortOption.topRated:
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }
    return list;
  }

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _query = '';
      _category = null;
      _price = _PriceFilter.all;
      _sort = _SortOption.relevance;
    });
  }

  void _openProduct(Product product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProductDetailScreen(productId: product.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final results = _results;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(context),
            _buildFilters(),
            _buildResultCount(context, results.length),
            Expanded(
              child: results.isEmpty
                  ? _EmptyState(onReset: _resetFilters)
                  : SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                      // ProductGrid dibuat untuk berada di dalam halaman
                      // yang bisa di-scroll (shrinkWrap).
                      child: ProductGrid(
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final product = results[index];
                          return ProductGridCard(
                            name: product.name,
                            price: product.price,
                            image: product.image,
                            rating: product.rating,
                            reviewCount: product.reviewCount,
                            location: product.location,
                            onTap: () => _openProduct(product),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 16, 8),
      child: Row(
        children: [
          if (Navigator.of(context).canPop())
            IconButton(
              tooltip: 'Kembali',
              icon: Icon(Icons.arrow_back, color: cs.onSurface),
              onPressed: () => Navigator.of(context).maybePop(),
            )
          else
            const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _query = value),
              textInputAction: TextInputAction.search,
              style: text.bodyMedium?.copyWith(color: cs.onSurface),
              decoration: InputDecoration(
                hintText: 'Cari produk, perajin, toko, atau daerah...',
                hintStyle: text.bodyMedium?.copyWith(
                  color: cs.onSurfaceVariant,
                ),
                prefixIcon: Icon(Icons.search, color: cs.onSurfaceVariant),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Hapus pencarian',
                        icon: Icon(
                          Icons.close,
                          color: cs.onSurfaceVariant,
                          size: 18,
                        ),
                        onPressed: () => setState(() {
                          _searchController.clear();
                          _query = '';
                        }),
                      ),
                filled: true,
                fillColor: _searchFill,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _FilterPill<String>(
            label: _category?.label ?? 'Kategori',
            active: _category != null,
            values: [
              _allCategories,
              ...ProductCategory.values.map((c) => c.name),
            ],
            labelOf: (v) => v == _allCategories
                ? 'Semua kategori'
                : ProductCategory.values.byName(v).label,
            onSelected: (v) => setState(() {
              _category = v == _allCategories
                  ? null
                  : ProductCategory.values.byName(v);
            }),
          ),
          const SizedBox(width: 8),
          _FilterPill<_PriceFilter>(
            label: _price == _PriceFilter.all ? 'Harga' : _price.label,
            active: _price != _PriceFilter.all,
            values: _PriceFilter.values,
            labelOf: (v) => v.label,
            onSelected: (v) => setState(() => _price = v),
          ),
          const SizedBox(width: 8),
          _FilterPill<_SortOption>(
            label: _sort == _SortOption.relevance ? 'Urutkan' : _sort.label,
            active: _sort != _SortOption.relevance,
            values: _SortOption.values,
            labelOf: (v) => v.label,
            onSelected: (v) => setState(() => _sort = v),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCount(BuildContext context, int count) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
        child: Text(
          '$count produk',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

/// Pil filter dengan menu pilihan. Dibuat sendiri (bukan PillButton) karena
/// butuh status aktif dan panah di kanan.
class _FilterPill<T> extends StatelessWidget {
  final String label;
  final bool active;
  final List<T> values;
  final String Function(T) labelOf;
  final ValueChanged<T> onSelected;

  const _FilterPill({
    required this.label,
    required this.active,
    required this.values,
    required this.labelOf,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final contentColor = active ? AppColors.primaryGreen : cs.onSurface;

    return PopupMenuButton<T>(
      tooltip: label,
      position: PopupMenuPosition.under,
      onSelected: onSelected,
      itemBuilder: (context) => [
        for (final v in values)
          PopupMenuItem<T>(value: v, child: Text(labelOf(v))),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: active ? AppColors.lightGreen : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: active ? AppColors.primaryGreen : cs.outlineVariant,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: contentColor,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              size: 18,
              color: active ? AppColors.primaryGreen : cs.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onReset;

  const _EmptyState({required this.onReset});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off, size: 48, color: cs.onSurfaceVariant),
            const SizedBox(height: 12),
            Text(
              'Produk tidak ditemukan',
              style: text.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: cs.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Coba ubah kata kunci atau filter yang dipakai.',
              textAlign: TextAlign.center,
              style: text.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: onReset,
              child: const Text('Reset filter'),
            ),
          ],
        ),
      ),
    );
  }
}