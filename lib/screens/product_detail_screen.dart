import 'package:flutter/material.dart';

import '../data/product_data.dart';
import '../models/product.dart';
import '../models/seller.dart';
import '../theme/app_colors.dart';
import '../utils/formatters.dart';
import '../widgets/app_image.dart';
import '../widgets/eco_badge.dart';
import '../widgets/info_chip.dart';
import 'seller_profile_screen.dart';

/// Halaman detail produk. Dipanggil dengan id produk:
/// ProductDetailScreen(productId: product.id)
class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool _favorite = false;
  int _photoIndex = 0;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleFavorite() {
    setState(() => _favorite = !_favorite);
  }

  void _openSellerProfile(Seller seller) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SellerProfileScreen(seller: seller)),
    );
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
    final product = findProductById(widget.productId);

    if (product == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Produk tidak ditemukan')),
      );
    }

    final seller = findSellerById(product.sellerId);
    final photos = product.photos;
    final index = _photoIndex < photos.length ? _photoIndex : 0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(photos, index),
                  if (photos.length > 1) _buildThumbnails(photos, index),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                    child: _buildBody(context, product, seller),
                  ),
                ],
              ),
            ),
          ),
          _buildBottomBar(context, product),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------- HEADER

  Widget _buildHeader(List<String> photos, int index) {
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: AspectRatio(
            aspectRatio: 1.1,
            child: Stack(
              fit: StackFit.expand,
              children: [
                AppImage(path: photos[index]),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: _CircleButton(
                      icon: Icons.arrow_back,
                      label: 'Kembali',
                      onTap: () => Navigator.of(context).maybePop(),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _CircleButton(
                          icon: Icons.share_outlined,
                          label: 'Bagikan',
                          onTap: () =>
                              _showMessage('Fitur bagikan belum tersedia'),
                        ),
                        const SizedBox(width: 8),
                        _CircleButton(
                          icon: _favorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          label: 'Favorit',
                          color: _favorite ? cs.error : cs.onSurface,
                          onTap: _toggleFavorite,
                        ),
                      ],
                    ),
                  ),
                ),
                if (photos.length > 1)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${index + 1}/${photos.length}',
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnails(List<String> photos, int selected) {
    return SizedBox(
      height: 72,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        itemCount: photos.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final isSelected = i == selected;
          return GestureDetector(
            onTap: () => setState(() => _photoIndex = i),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryGreen
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AppImage(path: photos[i]),
              ),
            ),
          );
        },
      ),
    );
  }

  // ------------------------------------------------------------------ BODY

  Widget _buildBody(BuildContext context, Product product, Seller? seller) {
    final text = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    final otherProducts = sampleProducts
        .where((p) => p.sellerId == product.sellerId && p.id != product.id)
        .take(8)
        .toList();
    final shopLabel = seller?.shopName ?? product.sellerName;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: text.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            color: cs.onSurface,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          formatRupiah(product.price),
          style: text.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primaryGreen,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            InfoChip(
              icon: Icons.star,
              iconColor: AppColors.star,
              label:
                  '${product.rating.toStringAsFixed(1)} '
                  '(${formatCount(product.reviewCount)} ulasan)',
            ),
            InfoChip(
              icon: Icons.location_on_outlined,
              label: product.location,
            ),
            if (product.isEcoFriendly) const EcoBadge(),
          ],
        ),
        const SizedBox(height: 24),
        const _SectionTitle('Informasi Perajin'),
        const SizedBox(height: 12),
        _SellerCard(
          product: product,
          seller: seller,
          onOpenProfile: seller == null ? null : () => _openSellerProfile(seller),
        ),
        const SizedBox(height: 24),
        const _SectionTitle('Detail Produk'),
        const SizedBox(height: 12),
        _InfoCard(
          child: Column(
            children: [
              _DetailRow(
                icon: Icons.category_outlined,
                label: 'Kategori',
                value: product.category.label,
              ),
              const SizedBox(height: 12),
              _DetailRow(
                icon: Icons.inventory_2_outlined,
                label: 'Bahan',
                value: product.material,
              ),
              const SizedBox(height: 12),
              _DetailRow(
                icon: Icons.handyman_outlined,
                label: 'Teknik',
                value: product.technique,
              ),
              const SizedBox(height: 12),
              _DetailRow(
                icon: Icons.eco_outlined,
                label: 'Ramah lingkungan',
                value: product.isEcoFriendly ? 'Ya' : 'Tidak',
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const _SectionTitle('Tentang Produk'),
        const SizedBox(height: 8),
        Text(
          product.description,
          style: text.bodyMedium?.copyWith(
            height: 1.5,
            color: cs.onSurfaceVariant,
          ),
        ),
        if (otherProducts.isNotEmpty) ...[
          const SizedBox(height: 24),
          _SectionTitle('Produk lain dari $shopLabel'),
          const SizedBox(height: 12),
          SizedBox(
            height: 240,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: otherProducts.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) => _MiniProductCard(
                product: otherProducts[i],
                onTap: () => _openProduct(otherProducts[i]),
              ),
            ),
          ),
        ],
      ],
    );
  }

  // ---------------------------------------------------------- BOTTOM BAR

  Widget _buildBottomBar(BuildContext context, Product product) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: cs.outlineVariant)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(
            children: [
              SizedBox(
                width: 52,
                height: 52,
                child: OutlinedButton(
                  onPressed: _toggleFavorite,
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    side: BorderSide(color: cs.outlineVariant),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Icon(
                    _favorite ? Icons.favorite : Icons.favorite_border,
                    color: _favorite ? cs.error : cs.onSurface,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: FilledButton.icon(
                    onPressed: () => _showMessage(
                      '"${product.name}" ditambahkan ke keranjang',
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text('Keranjang'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      foregroundColor: Colors.white,
                      textStyle: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
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

// ============================================================================
// Widget kecil (private)
// ============================================================================

/// Kontainer informasi: kartu putih dengan border tipis dan sudut membulat.
class _InfoCard extends StatelessWidget {
  final Widget child;

  const _InfoCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: child,
    );
  }
}

/// Kartu perajin. Data lengkap diambil dari Seller (seller.dart).
/// Kalau sellerId belum ada di dummySellers, tampil data cadangan dari Product.
class _SellerCard extends StatelessWidget {
  final Product product;
  final Seller? seller;
  final VoidCallback? onOpenProfile;

  const _SellerCard({
    required this.product,
    required this.seller,
    required this.onOpenProfile,
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    final name = seller?.name ?? product.sellerName;
    final subtitle = seller?.shopName ?? product.sellerRole;

    return _InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 56,
                height: 56,
                child: ClipOval(
                  child: seller != null
                      ? AppImage(
                          path: seller!.photo,
                          placeholderIcon: Icons.person,
                        )
                      : _InitialAvatar(name: name),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: text.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: cs.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: text.bodyMedium?.copyWith(
                        color: AppColors.primaryGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (seller != null) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                InfoChip(
                  icon: Icons.star,
                  iconColor: AppColors.star,
                  label:
                      '${seller!.rating.toStringAsFixed(1)} Rating Toko '
                      '(${formatCount(seller!.reviewCount)})',
                ),
                if (seller!.isTrusted)
                  const InfoChip(
                    icon: Icons.verified_user,
                    label: 'Penjual Terpercaya',
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              seller!.story,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: text.bodyMedium?.copyWith(
                height: 1.5,
                color: cs.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.tonalIcon(
                onPressed: onOpenProfile,
                icon: const Icon(Icons.storefront_outlined),
                label: const Text('Lihat Profil Perajin'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Kartu produk kecil untuk daftar "Produk lain dari toko ini".
class _MiniProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const _MiniProductCard({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SizedBox(
      width: 150,
      child: Material(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: cs.outlineVariant),
        ),
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: AppImage(path: product.image),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: cs.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatRupiah(product.price),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryGreen,
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

class _InitialAvatar extends StatelessWidget {
  final String name;

  const _InitialAvatar({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightGreen,
      alignment: Alignment.center,
      child: Text(
        name.isNotEmpty ? name[0] : '?',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.primaryGreen,
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _CircleButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Tooltip(
          message: label,
          child: Padding(
            padding: const EdgeInsets.all(9),
            child: Icon(
              icon,
              size: 20,
              color: color ?? Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.primaryGreen),
        const SizedBox(width: 10),
        Text(
          '$label: ',
          style: text.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
        ),
        Expanded(
          child: Text(
            value,
            style: text.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}