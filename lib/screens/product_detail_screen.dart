import 'package:flutter/material.dart';

import '../data/product_data.dart';
import '../data/seller_bridge.dart';
import '../models/product.dart';
import '../models/seller.dart';
import 'craft_components.dart';
import 'craft_format.dart';
import 'craft_layout.dart';
import 'craft_photo_gallery.dart';
import 'craft_seller_card.dart';
import 'craft_theme.dart';
import 'seller_profile_screen.dart';

/// Halaman Detail Produk
/// Tahap 1 (M01-M03): Text, Image & Modular Components
/// Tahap 2 (M04-M05): Material Design 3 & Single-Child Layouts
/// Tahap 3 (M06-M07): Multi-Child Layouts & Responsive UI
///
/// Layar sempit (ponsel): satu kolom, galeri di atas lalu informasi.
/// Layar lebar (tablet atau landscape): dua kolom berdampingan, galeri di
/// kiri dan informasi di kanan. Pilihan susunan ditentukan LayoutBuilder.
class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool _isFavorite = false;
  int _photoIndex = 0;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  /// Gerbang ke halaman Profil Perajin (dikerjakan anggota tim lain).
  void _openSellerProfile(Seller seller) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SellerProfileScreen(seller: seller),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = findProductById(widget.productId);

    // Theme menerapkan CraftOrigin Visual System. Builder dipakai supaya
    // Theme.of(context) di bawah membaca craftTheme.
    return Theme(
      data: craftTheme,
      child: Builder(
        builder: (context) {
          if (product == null) {
            return Scaffold(
              appBar: AppBar(title: const Text('Detail Produk')),
              body: const Center(child: Text('Produk tidak ditemukan')),
            );
          }

          // Data perajin diambil lewat seller_bridge (menghubungkan data
          // produk dengan model Seller milik tim).
          final seller = sellerForProduct(product);
          final photos = product.photos;
          final photoIndex = _photoIndex < photos.length ? _photoIndex : 0;

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide =
                            constraints.maxWidth >= CraftBreakpoints.medium;

                        final gallery = ProductPhotoGallery(
                          photos: photos,
                          selectedIndex: photoIndex,
                          onSelect: (index) {
                            setState(() {
                              _photoIndex = index;
                            });
                          },
                          isFavorite: _isFavorite,
                          onToggleFavorite: _toggleFavorite,
                          onShare: () =>
                              _showMessage('Fitur bagikan belum tersedia'),
                          onBack: () => Navigator.of(context).maybePop(),
                        );

                        final info = _buildInfo(
                          context,
                          product,
                          seller,
                          isWide: isWide,
                        );

                        if (isWide) {
                          return _buildWideLayout(gallery, info);
                        }
                        return _buildNarrowLayout(gallery, info);
                      },
                    ),
                  ),
                  _buildBottomBar(context, product),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Layar sempit: satu kolom yang bisa di-scroll.
  Widget _buildNarrowLayout(Widget gallery, Widget info) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(CraftSpacing.lg),
          child: gallery,
        ),
        info,
        const SizedBox(height: CraftSpacing.xl),
      ],
    );
  }

  /// Layar lebar: Row dengan dua kolom, masing-masing bisa di-scroll sendiri.
  /// Lebar isi dibatasi agar tidak melebar berlebihan di layar sangat besar.
  Widget _buildWideLayout(Widget gallery, Widget info) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(CraftSpacing.lg),
                child: gallery,
              ),
            ),
            Expanded(
              flex: 6,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: CraftSpacing.xl),
                child: info,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Kolom informasi: nama, harga, badge, kartu perajin, detail, deskripsi.
  Widget _buildInfo(
    BuildContext context,
    Product product,
    Seller seller, {
    required bool isWide,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            CraftSpacing.lg,
            isWide ? CraftSpacing.lg : 0,
            CraftSpacing.lg,
            CraftSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(product.name, style: textTheme.headlineSmall),
              const SizedBox(height: CraftSpacing.xs),
              Text(
                formatPrice(product.price),
                style: textTheme.titleLarge?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: CraftSpacing.md),
              // Wrap menurunkan badge ke baris berikutnya jika tidak muat.
              Wrap(
                spacing: CraftSpacing.sm,
                runSpacing: CraftSpacing.sm,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  InfoPill(
                    icon: Icons.star,
                    label: '${product.rating} (${product.reviewCount} ulasan)',
                  ),
                  InfoPill(
                    icon: Icons.location_on_outlined,
                    label: product.location,
                  ),
                  if (product.isEcoFriendly) const EcoFriendlyBadge(),
                ],
              ),
            ],
          ),
        ),

        // Perajin: menampilkan data seller dan menjadi gerbang ke profilnya.
        SellerGateCard(
          seller: seller,
          onOpenProfile: () => _openSellerProfile(seller),
        ),

        InfoContainer(
          title: 'Detail Produk',
          child: Column(
            children: [
              InfoRow(
                icon: Icons.category_outlined,
                label: 'Kategori',
                value: product.category.label,
              ),
              InfoRow(
                icon: Icons.inventory_2_outlined,
                label: 'Bahan',
                value: product.material,
              ),
              InfoRow(
                icon: Icons.handyman_outlined,
                label: 'Teknik',
                value: product.technique,
              ),
              InfoRow(
                icon: Icons.eco_outlined,
                label: 'Ramah lingkungan',
                value: product.isEcoFriendly ? 'Ya' : 'Tidak',
              ),
            ],
          ),
        ),

        InfoContainer(
          title: 'Tentang Produk',
          child: Text(
            product.description,
            style: textTheme.bodyMedium?.copyWith(
              height: 1.5,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  /// Bar bawah: tombol favorit (kotak) dan tombol Keranjang (memanjang).
  Widget _buildBottomBar(BuildContext context, Product product) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(CraftSpacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 52,
            height: 52,
            child: OutlinedButton(
              onPressed: _toggleFavorite,
              style: OutlinedButton.styleFrom(padding: EdgeInsets.zero),
              child: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? colorScheme.error : colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(width: CraftSpacing.md),
          Expanded(
            child: SizedBox(
              height: 52,
              child: FilledButton.icon(
                onPressed: () => _showMessage(
                  '"${product.name}" ditambahkan ke keranjang',
                ),
                icon: const Icon(Icons.add),
                label: const Text('Keranjang'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}