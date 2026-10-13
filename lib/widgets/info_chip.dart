import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Chip informasi kecil dengan ikon, contoh: "4.9 Rating Toko".
class InfoChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;

  const InfoChip({
    super.key,
    required this.icon,
    required this.label,
    this.iconColor = AppColors.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
