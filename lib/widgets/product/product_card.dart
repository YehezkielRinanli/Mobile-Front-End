import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../../models/product.dart';
import '../../utils/formatters.dart';
import '../common/eco_badge.dart';
import 'product_image.dart';
import 'product_info.dart';

class ProductCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String price;
  final String ecoLabel;
  final bool isEcoFriendly;
  final double? width;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.price,
    this.ecoLabel = 'Ramah Lingkungan',
    this.isEcoFriendly = true,
    this.width,
    this.onTap,
  });

  factory ProductCard.fromProduct({
    Key? key,
    required Product product,
    double? width,
    VoidCallback? onTap,
  }) {
    return ProductCard(
      key: key,
      imagePath: product.image,
      name: product.name,
      price: formatRupiah(product.price),
      ecoLabel: 'Ramah Lingkungan',
      isEcoFriendly: product.isEcoFriendly,
      width: width,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      child: Container(
        width: width,
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: colors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ProductImage(
              imagePath: imagePath,
              width: double.infinity,
              height: 130,
            ),
            ProductInfo(name: name, price: price),
            if (isEcoFriendly) EcoBadge(label: ecoLabel),
          ],
        ),
      ),
    );
  }
}