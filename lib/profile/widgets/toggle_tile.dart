import 'package:flutter/material.dart';
import 'profile_colors.dart';

/// Baris pengaturan dengan tombol on/off.
/// Dibuat dari Row + Icon (toggle_on / toggle_off), tanpa widget Switch.
/// Nilai disimpan oleh halaman pemakainya (lewat setState).
class ToggleTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const ToggleTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final c = PColors.of(context);

    // ===== M09 (Navigation & User Interaction) - MULAI =====
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(!value),
      // ===== M09 - SELESAI =====
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(icon, color: c.primary, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: c.heading)),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: c.secondary),
                  ),
                ],
              ),
            ),
            Icon(
              value ? Icons.toggle_on : Icons.toggle_off,
              size: 44,
              color: value ? c.primary : c.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
