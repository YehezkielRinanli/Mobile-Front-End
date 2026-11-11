import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../../models/seller.dart';
import '../app_image.dart';

class SellerCard extends StatelessWidget {
  final Seller seller;
  final VoidCallback? onTap;

  const SellerCard({
    super.key,
    required this.seller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: colors.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              SizedBox(
                width: 64,
                height: 64,
                child: ClipOval(
                  child: AppImage(
                    path: seller.photo,
                    placeholderIcon: Icons.person,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      seller.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      seller.shopName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colors.primary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          seller.rating.toStringAsFixed(1),
                          style: textTheme.bodyMedium,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Icon(Icons.location_on, size: 16, color: colors.primary),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            seller.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: colors.outline),
            ],
          ),
        ),
      ),
    );
  }
}