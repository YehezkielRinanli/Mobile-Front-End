import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';

class SellerSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const SellerSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Cari nama perajin, misal "Siti"',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: controller.text.isEmpty
            ? null
            : IconButton(
                icon: const Icon(Icons.close),
                onPressed: onClear,
              ),
        filled: true,
        fillColor: colors.surfaceContainerHigh,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}