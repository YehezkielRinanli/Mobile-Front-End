import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';

class RatingInfo extends StatelessWidget {
  final String rating;
  final String reviewCount;

  const RatingInfo({
    super.key,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 20),
        const SizedBox(width: AppSpacing.xs),
        RichText(
          text: TextSpan(
            style: textTheme.bodyLarge?.copyWith(color: colors.onSurface),
            children: [
              TextSpan(
                text: rating,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' Rating Toko ($reviewCount Ulasan)'),
            ],
          ),
        ),
      ],
    );
  }
}