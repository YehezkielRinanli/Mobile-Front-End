import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';

class ContactLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ContactLabel({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: colors.secondaryContainer,
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: colors.onSecondaryContainer),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: RichText(
              text: TextSpan(
                style: textTheme.bodyLarge?.copyWith(
                  color: colors.onSecondaryContainer,
                ),
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}