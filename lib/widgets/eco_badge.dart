import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Label hijau "Eco-Friendly" untuk produk ramah lingkungan.
class EcoBadge extends StatelessWidget {
  const EcoBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, size: 12, color: AppColors.primaryGreen),
          SizedBox(width: 4),
          Text(
            'Eco-Friendly',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryGreen,
            ),
          ),
        ],
      ),
    );
  }
}
