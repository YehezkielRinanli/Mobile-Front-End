import 'package:flutter/material.dart';

import '../../core/constants/app_breakpoints.dart';
import '../../core/constants/app_spacing.dart';
import '../../models/product.dart';
import '../../utils/formatters.dart';
import 'product_card.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  final String? ecoLabel;
  final ValueChanged<Product>? onProductTap;

  const ProductGrid({
    super.key,
    required this.products,
    this.ecoLabel,
    this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isWide = screenWidth >= AppBreakpoints.wide;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isWide ? 3 : 2,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        mainAxisExtent: 290,
      ),
      itemBuilder: (context, index) {
        final product = products[index];

        return ProductCard(
          imagePath: product.image,
          name: product.name,
          price: formatRupiah(product.price),
          ecoLabel: ecoLabel ?? 'Ramah Lingkungan',
          isEcoFriendly: product.isEcoFriendly,
          onTap: () => onProductTap?.call(product),
        );
      },
    );
  }
}