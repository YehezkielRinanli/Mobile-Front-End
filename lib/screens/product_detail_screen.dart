import 'package:flutter/material.dart';

import '../data/product_data.dart';
import '../models/product.dart';
import '../models/seller.dart';
import '../theme/app_colors.dart';
import '../utils/formatters.dart';
import '../widgets/app_image.dart';
import '../widgets/eco_badge.dart';
import '../widgets/info_chip.dart';
import '../widgets/pill_button.dart';
import 'seller_profile_screen.dart';

const Color _text = Colors.black87;
const Color _muted = Color(0xFF6B756F);
const Color _line = Color(0xFFE0DBCF);

/// Halaman detail produk. Dipanggil dengan id produk, sesuai TODO di
/// seller_profile_screen.dart:
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

  /// Fungsi pembantu untuk mencari seller berdasarkan ID dari dummySellers
  Seller? _findSellerById(String sellerId) {
    try {
      return dummySellers.firstWhere((s) => s.id == sellerId);
    } catch (_) {
      return null;
    }
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
                  _buildHeader(context, photos, index),
                  if (photos.length > 1) _buildThumbnails(photos, index),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                    child: _buildBody(product),
                  ),
                ],
              ),
            ),
          ),
          _buildBottomBar(product),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, List<String> photos, int index) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: AspectRatio(
            aspectRatio: 1.1,
            child: Stack(
              fit: StackFit.expand,
              children: [
                AppImage(path: photos[index]),
                Positioned(
                  top: 12,
                  left: 12,
                  child: _CircleButton(
                    icon: Icons.arrow_back,
                    label: 'Kembali',
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Row(
                    children: [
                      _CircleButton(
                        icon: Icons.share_outlined,
                        label: 'Bagikan',
                        onTap: () =>
                            _showMessage('Fitur bagikan belum tersedia'),
                      ),
                      const SizedBox(width: 8),
                      _CircleButton(
                        icon:
                            _favorite ? Icons.favorite : Icons.favorite_border,
                        label: 'Favorit',
                        color: _favorite ? Colors.red : _text,
                        onTap: _toggleFavorite,
                      ),
                    ],
                  ),
                ),
                if (photos.length > 1)
                  Positioned(
                    right: 12,
                    bottom: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0x99000000),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${index + 1}/${photos.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
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
        separatorBuilder: (context, index) => const SizedBox(width: 8),
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

  Widget _buildBody(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: _text,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          formatRupiah(product.price),
          style: const TextStyle(
            fontSize: 20,
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
        const _SectionDivider(),
        const _SectionTitle('Informasi Perajin'),
        const SizedBox(height: 12),
        _buildSellerInfo(product),
        const _SectionDivider(),
        const _SectionTitle('Detail Produk'),
        const SizedBox(height: 12),
        _DetailRow(
          icon: Icons.category_outlined,
          label: 'Kategori',
          value: product.category.label,
        ),
        _DetailRow(
          icon: Icons.inventory_2_outlined,
          label: 'Bahan',
          value: product.material,
        ),
        _DetailRow(
          icon: Icons.handyman_outlined,
          label: 'Teknik',
          value: product.technique,
        ),
        _DetailRow(
          icon: Icons.eco_outlined,
          label: 'Ramah lingkungan',
          value: product.isEcoFriendly ? 'Ya' : 'Tidak',
        ),
        const _SectionDivider(),
        const _SectionTitle('Tentang Produk'),
        const SizedBox(height: 8),
        Text(
          product.description,
          style: const TextStyle(fontSize: 14, height: 1.5, color: _muted),
        ),
      ],
    );
  }

  /// Data penjual diambil dari models/seller.dart lewat sellerId.
  /// Kalau id-nya belum ada di sana, dipakai data cadangan di Product
  /// (inisial nama, tanpa tombol Lihat Profil).
  Widget _buildSellerInfo(Product product) {
    final seller = _findSellerById(product.sellerId);
    final name = seller?.name ?? product.sellerName;
    final subtitle = seller?.shopName ?? product.sellerRole;

    return Row(
      children: [
        ClipOval(
          child: SizedBox(
            width: 52,
            height: 52,
            child: seller != null
                ? AppImage(path: seller.photo, placeholderIcon: Icons.person)
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
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: _text,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.primaryGreen,
                ),
              ),
            ],
          ),
        ),
        if (seller != null) ...[
          const SizedBox(width: 8),
          PillButton(
            icon: Icons.storefront_outlined,
            label: 'Lihat Profil',
            onTap: () => _openSellerProfile(seller),
          ),
        ],
      ],
    );
  }

  Widget _buildBottomBar(Product product) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: _line)),
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
                    side: const BorderSide(color: _line),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Icon(
                    _favorite ? Icons.favorite : Icons.favorite_border,
                    color: _favorite ? Colors.red : _text,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () => _showMessage(
                      '"${product.name}" ditambahkan ke keranjang',
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text(
                      'Keranjang',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      foregroundColor: Colors.white,
                      elevation: 0,
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
        style: const TextStyle(
          fontSize: 20,
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
  final Color color;

  const _CircleButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = _text,
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
            child: Icon(icon, size: 20, color: color),
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
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: _text,
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Divider(height: 1, color: _line),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.primaryGreen),
          const SizedBox(width: 10),
          Text(
            '$label: ',
            style: const TextStyle(fontSize: 14, color: _muted),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}