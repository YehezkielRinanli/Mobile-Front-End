import 'package:flutter/material.dart';

import '../core/constants/app_spacing.dart';
import '../data/product_data.dart';
import '../models/seller.dart';
import '../widgets/common/section_title.dart';
import '../widgets/common/trusted_badge.dart';
import '../widgets/product/product_grid.dart';
import '../widgets/profile/seller_header.dart';
import '../widgets/profile/seller_story.dart';
import 'product_detail_screen.dart';

class SellerProfileScreen extends StatelessWidget {
  final Seller seller;

  const SellerProfileScreen({super.key, required this.seller});

  @override
  Widget build(BuildContext context) {
    final sellerProducts = sampleProducts
        .where((product) => product.sellerId == seller.id)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(seller.shopName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SellerHeader.fromSeller(seller: seller),
            const SizedBox(height: AppSpacing.md),
            const TrustedBadge(),
            const SizedBox(height: AppSpacing.md),
            SellerStory(story: seller.bio),
            const SizedBox(height: AppSpacing.lg),
            const SectionTitle(title: 'Katalog Produk'),
            ProductGrid(
              products: sellerProducts.isNotEmpty ? sellerProducts : sampleProducts,
              onProductTap: (product) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(productId: product.id),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}