import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';

class SellerStory extends StatelessWidget {
  final String title;
  final String story;

  const SellerStory({
    super.key,
    this.title = 'Kisah Perajin',
    required this.story,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: RichText(
        text: TextSpan(
          style: textTheme.bodyLarge?.copyWith(
            color: colors.onSurface,
            height: 1.4,
          ),
          children: [
            TextSpan(
              text: '$title\n\n',
              style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: story),
          ],
        ),
      ),
    );
  }
}