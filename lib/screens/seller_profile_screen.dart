import 'package:flutter/material.dart';

import '../models/seller.dart';
import '../theme/app_colors.dart';
import '../utils/formatters.dart';
import '../widgets/info_chip.dart';
import '../widgets/product_grid.dart';
import '../widgets/product_grid_card.dart';
import '../widgets/seller_header_card.dart';
import 'product_detail_screen.dart';

/// Extension untuk melengkapi properti opsional tanpa mengubah file model asli
extension SellerExtension on Seller {
  int get reviewCount => 128;
  bool get isTrusted => rating >= 4.8;
  String get story => bio.isNotEmpty
      ? bio
      : 'Memperkenalkan karya kerajinan tangan berkualitas tinggi yang dibuat dengan ketelitian dan semangat menjaga warisan budaya lokal.';
  String get email => 'kontak@${shopName.toLowerCase().replaceAll(' ', '')}.com';
  String get phone => '+6281234567890';
}

extension SellerProductExtension on SellerProduct {
  double get rating => 4.8;
  int get reviewCount => 42;
  int get numericPrice {
    final cleanStr = price.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(cleanStr) ?? 0;
  }
}

class SellerProfileScreen extends StatefulWidget {
  final Seller? seller;

  const SellerProfileScreen({super.key, this.seller});

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  bool _isFollowing = false;

  Seller get _activeSeller =>
      widget.seller ??
      (dummySellers.isNotEmpty
          ? dummySellers.first
          : const Seller(
              id: 's1',
              name: 'Ibu Siti',
              shopName: 'Rumah Rotan',
              photo: 'assets/images/seller_siti_aminah.jpg',
              location: 'Bali',
              bio: 'Perajin anyaman rotan ramah lingkungan.',
              rating: 4.9,
              products: [],
            ));

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _sendEmail() {
    _showMessage('Fitur email belum tersambung');
  }

  void _callSeller() {
    _showMessage('Fitur telepon belum tersambung');
  }

  void _openProduct(SellerProduct product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProductDetailScreen(productId: product.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final seller = _activeSeller;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SellerHeaderCard(
                seller: seller,
                isFollowing: _isFollowing,
                onFollowTap: () => setState(() => _isFollowing = !_isFollowing),
                onEmailTap: _sendEmail,
                onPhoneTap: _callSeller,
              ),
              const SizedBox(height: 12),
              _buildBadges(seller),
              const SizedBox(height: 20),
              _buildStory(seller),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(height: 1, color: Color(0xFFE0DBCF)),
              ),
              _buildCatalog(seller),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primaryGreen,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      leadingWidth: 64,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Center(
          child: Material(
            color: AppColors.cream,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () => Navigator.maybePop(context),
              child: const SizedBox(
                width: 36,
                height: 36,
                child: Icon(
                  Icons.chevron_left,
                  size: 24,
                  color: AppColors.primaryGreen,
                ),
              ),
            ),
          ),
        ),
      ),
      centerTitle: true,
      title: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.account_circle, color: AppColors.cream, size: 28),
          SizedBox(width: 8),
          Text(
            'Profil Perajin',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.cream,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadges(Seller seller) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        InfoChip(
          icon: Icons.star,
          iconColor: AppColors.star,
          label:
              '${seller.rating.toStringAsFixed(1)} Rating Toko '
              '(${formatCount(seller.reviewCount)} Ulasan)',
        ),
        if (seller.isTrusted)
          const InfoChip(
            icon: Icons.verified_user,
            label: 'Penjual Terpercaya',
          ),
      ],
    );
  }

  Widget _buildStory(Seller seller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cerita di Balik Karya',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          seller.story,
          style: const TextStyle(
            fontSize: 14,
            height: 1.5,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildCatalog(Seller seller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Katalog Produk ${seller.shopName}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        ProductGrid(
          itemCount: seller.products.length,
          itemBuilder: (context, index) {
            final product = seller.products[index];
            return ProductGridCard(
              name: product.name,
              price: product.numericPrice,
              image: product.image,
              rating: product.rating,
              reviewCount: product.reviewCount,
              location: product.location,
              onTap: () => _openProduct(product),
            );
          },
        ),
      ],
    );
  }
}