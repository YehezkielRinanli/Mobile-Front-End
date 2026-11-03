
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

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

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 2,
      ),
      leading: Icon(
        icon,
        color: iconColor,
        size: 23,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: arrowColor,
        size: 22,
      ),
      minLeadingWidth: 28,
      onTap: onTap,
    );
  }
}
