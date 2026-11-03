import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';

class ShopTag extends StatelessWidget {
  final String name;

  const ShopTag({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.store, size: 18, color: colors.primary),
          const SizedBox(width: AppSpacing.sm),
          Text(name, style: textTheme.titleMedium),
        ],
      ),
    );
  }
}