import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';

class TrustedBadge extends StatelessWidget {
  final String label;

  const TrustedBadge({
    super.key,
    this.label = 'Terverifikasi',
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
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified_user, size: 18, color: colors.primary),
          const SizedBox(width: AppSpacing.sm),
          Text(label, style: textTheme.bodyLarge),
        ],
      ),
    );
  }
}