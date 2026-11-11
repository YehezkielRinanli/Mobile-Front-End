import 'package:flutter/material.dart';

import '../models/product.dart';
import 'craft_theme.dart';

/// Custom Reusable Widget: baris pilihan kategori yang bisa digeser ke
/// samping (ListView horizontal). Pilihan "Semua" berarti tanpa filter.
class CategoryFilterBar extends StatelessWidget {
  final List<ProductCategory> categories;
  final ProductCategory? selected;
  final ValueChanged<ProductCategory?> onSelected;

  const CategoryFilterBar({
    super.key,
    required this.categories,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: CraftSpacing.lg,
          vertical: CraftSpacing.sm,
        ),
        children: [
          _CategoryChip(
            label: 'Semua',
            isSelected: selected == null,
            onTap: () => onSelected(null),
          ),
          for (final category in categories) ...[
            const SizedBox(width: CraftSpacing.sm),
            _CategoryChip(
              label: category.label,
              isSelected: selected == category,
              onTap: () => onSelected(category),
            ),
          ],
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // ChoiceChip adalah widget bantu bawaan Material 3 untuk pilihan tunggal.
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      showCheckmark: false,
      onSelected: (_) => onTap(),
    );
  }
}
