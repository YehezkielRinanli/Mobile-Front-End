import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';

class ProductInfo extends StatelessWidget {
  final String name;
  final String price;

  const ProductInfo({
    super.key,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.md,
        top: AppSpacing.sm,
        right: AppSpacing.md,
      ),
      child: RichText(
        text: TextSpan(
          style: textTheme.titleMedium?.copyWith(color: colors.onSurface),
          children: [
            TextSpan(text: '$name\n'),
            TextSpan(
              text: price,
              style: textTheme.titleLarge?.copyWith(
                color: colors.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}