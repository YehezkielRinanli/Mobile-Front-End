import 'package:flutter/material.dart';
import 'profile_colors.dart';

/// Kartu pembungkus isi halaman.
/// Hanya Container + BoxDecoration.
class SectionCard extends StatelessWidget {
  final Widget child;

  const SectionCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final c = PColors.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: c.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: c.border),
      ),
      child: child,
    );
  }
}
