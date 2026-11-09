import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';

class EcoBadge extends StatelessWidget {
  final String label;

  const EcoBadge({
    super.key,
    this.label = 'Ramah Lingkungan', // Memiliki nilai bawaan agar bisa dipanggil const EcoBadge()
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            size: 14,
            color: colors.onPrimaryContainer,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: textTheme.labelLarge?.copyWith(
              color: colors.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}