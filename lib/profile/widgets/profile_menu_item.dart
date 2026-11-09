import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Satu baris menu profil.
/// [M06] Row: Icon - Expanded(Text) - Icon, sehingga teks mengisi sisa
/// ruang dan tidak overflow saat judul panjang.
/// [M05] Padding untuk jarak di dalam baris.
class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    final iconColor = isDark
        ? const Color(0xFFA8C9A5)
        : AppColors.primaryGreen;

    final titleColor = isDark
        ? const Color(0xFFF1EFE9)
        : AppColors.darkGreen;

    final arrowColor = isDark
        ? const Color(0xFFBEC8BE)
        : Colors.grey.shade600;

    // ===== M09 (Navigation & User Interaction) - MULAI =====
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      // ===== M09 - SELESAI =====
      child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 23),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: titleColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Icon(Icons.chevron_right, color: arrowColor, size: 22),
        ],
      ),
    ));
  }
}
