import 'package:flutter/material.dart';
import 'profile_colors.dart';

/// Satu baris informasi: ikon - (label kecil + nilai) - widget kanan.
/// [M06] Row + Expanded + Column agar teks panjang tidak overflow.
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Widget? trailing;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final c = PColors.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: c.primary, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(fontSize: 12, color: c.secondary)),
                const SizedBox(height: 2),
                Text(value,
                    style: TextStyle(fontSize: 14, color: c.heading)),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
