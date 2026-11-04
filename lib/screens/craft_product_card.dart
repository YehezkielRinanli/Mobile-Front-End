import 'package:flutter/material.dart';

import '../models/product.dart';
import 'craft_components.dart';
import 'craft_format.dart';
import 'craft_theme.dart';

/// Custom Reusable Widget: kartu produk untuk grid (Tahap 3).
///
/// Susunan: Column berisi foto (Stack: foto + badge Eco-Friendly di atasnya)
/// dan area teks. Tinggi kartu ditentukan oleh grid, jadi area teks memakai
/// Expanded dan semua teks dibatasi satu atau dua baris agar tidak overflow.
class CraftProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const CraftProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(CraftRadius.md),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Foto persegi dengan badge di pojok kiri atas.
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    color: colorScheme.surfaceContainerHighest,
                    child: Image.asset(
                      product.image,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.image_outlined,
                          size: 40,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                  if (product.isEcoFriendly)
                    const Positioned(
                      top: CraftSpacing.sm,
                      left: CraftSpacing.sm,
                      child: EcoFriendlyBadge(),
                    ),
                ],
              ),
            ),
            // Area teks mengisi sisa tinggi kartu.
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(CraftSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleSmall,
                    ),
                    const SizedBox(height: CraftSpacing.xs),
                    Text(
                      formatPrice(product.price),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: CraftSpacing.xs),
                    _IconText(
                      icon: Icons.star,
                      text: '${product.rating} (${product.reviewCount})',
                    ),
                    const SizedBox(height: 2),
                    _IconText(
                      icon: Icons.location_on_outlined,
                      text: product.location,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Satu baris kecil: ikon lalu teks satu baris (Row + Expanded).
class _IconText extends StatelessWidget {
  final IconData icon;
  final String text;

  const _IconText({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(icon, size: 14, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: CraftSpacing.xs),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
