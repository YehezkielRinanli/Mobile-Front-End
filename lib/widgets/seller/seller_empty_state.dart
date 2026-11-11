import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';

class SellerEmptyState extends StatelessWidget {
  final String query;

  const SellerEmptyState({
    super.key,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off, size: 48, color: colors.outline),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Perajin tidak ditemukan',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Tidak ada nama perajin yang cocok dengan "$query".',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}