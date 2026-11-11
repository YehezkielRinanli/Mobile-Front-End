import 'package:flutter/material.dart';

import '../data/product_data.dart';
import '../models/product.dart';
import 'craft_category_bar.dart';
import 'craft_components.dart';
import 'craft_layout.dart';
import 'craft_product_card.dart';
import 'craft_theme.dart';
import 'product_detail_screen.dart';

/// Halaman Explore / Katalog Produk
/// Tahap 1 (M01-M03): Basic UI Layout & Reusability
/// Tahap 2 (M04-M05): Material Design 3 & Single-Child Layouts
/// Tahap 3 (M06-M07): Multi-Child Layouts & Responsive UI
///
/// Susunan halaman: Column berisi banner SDG, baris kategori (ListView
/// horizontal), dan grid produk (GridView) yang jumlah kolomnya mengikuti
/// lebar layar lewat LayoutBuilder.
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  ProductCategory? _selectedCategory;

  /// Produk yang ditampilkan: semua, atau hanya satu kategori.
  List<Product> get _visibleProducts {
    if (_selectedCategory == null) return sampleProducts;
    return sampleProducts
        .where((product) => product.category == _selectedCategory)
        .toList();
  }

  /// Hanya kategori yang punya produk, supaya tidak ada pilihan kosong.
  List<ProductCategory> get _categoriesWithProducts {
    return ProductCategory.values
        .where(
          (category) =>
              sampleProducts.any((product) => product.category == category),
        )
        .toList();
  }

  void _openProduct(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailScreen(productId: product.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Theme menerapkan CraftOrigin Visual System pada halaman ini.
    // Builder diperlukan supaya Theme.of(context) di bawah membaca craftTheme.
    return Theme(
      data: craftTheme,
      child: Builder(
        builder: (context) {
          final products = _visibleProducts;

          return Scaffold(
            appBar: AppBar(
              title: const Text('CraftOrigin - Katalog Produk'),
            ),
            body: Column(
              children: [
                const _SdgBanner(),
                CategoryFilterBar(
                  categories: _categoriesWithProducts,
                  selected: _selectedCategory,
                  onSelected: (category) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                ),
                Expanded(
                  child: products.isEmpty
                      ? const _EmptyState()
                      : _buildProductGrid(products),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Grid responsif. LayoutBuilder memberi lebar area yang tersedia, dari
  /// situ dihitung jumlah kolom dan tinggi tiap kartu sehingga isi kartu
  /// selalu muat (tanpa overflow) di ukuran layar apa pun.
  Widget _buildProductGrid(List<Product> products) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const horizontalPadding = CraftSpacing.lg;
        const gap = CraftSpacing.md;

        final columns = gridColumnsFor(constraints.maxWidth);
        final cellWidth = (constraints.maxWidth -
                horizontalPadding * 2 -
                gap * (columns - 1)) /
            columns;
        // Tinggi kartu = foto persegi (selebar kartu) + area teks.
        final cardHeight = cellWidth + cardInfoHeight(context);

        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(
            horizontalPadding,
            CraftSpacing.sm,
            horizontalPadding,
            CraftSpacing.xl,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: gap,
            mainAxisSpacing: gap,
            mainAxisExtent: cardHeight,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return CraftProductCard(
              product: product,
              onTap: () => _openProduct(product),
            );
          },
        );
      },
    );
  }
}

/// Banner pembuka: pesan SDG dan dua badge. Row dengan Expanded membuat
/// teks mengisi sisa lebar dan turun baris jika layar sempit.
class _SdgBanner extends StatelessWidget {
  const _SdgBanner();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(
        CraftSpacing.lg,
        CraftSpacing.md,
        CraftSpacing.lg,
        0,
      ),
      padding: const EdgeInsets.all(CraftSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(CraftRadius.md),
      ),
      child: Row(
        children: [
          Icon(Icons.eco, color: colorScheme.onPrimaryContainer),
          const SizedBox(width: CraftSpacing.md),
          Expanded(
            child: Text(
              'Produk perajin ramah lingkungan. Mendukung SDG 8 (Pekerjaan Layak) dan SDG 12 (Konsumsi Bertanggung Jawab).',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          const SizedBox(width: CraftSpacing.md),
          const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SdgBadge(label: 'SDG 8'),
              SizedBox(height: CraftSpacing.xs),
              SdgBadge(label: 'SDG 12'),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(CraftSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off,
              size: 48,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: CraftSpacing.md),
            Text('Belum ada produk', style: textTheme.titleMedium),
            const SizedBox(height: CraftSpacing.xs),
            Text(
              'Produk untuk kategori ini belum tersedia.',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}