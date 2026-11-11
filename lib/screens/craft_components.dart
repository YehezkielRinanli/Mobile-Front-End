import 'package:flutter/material.dart';

import 'craft_theme.dart';

// ============================================================================
// KOMPONEN REUSABLE HALAMAN PRODUCT (Tahap 2, M04-M05)
// Dibangun dari Container, Padding, SizedBox, dan Align.
// Semua warna dan huruf diambil dari Theme, bukan ditulis langsung.
// ============================================================================

/// Badge hijau "Eco-Friendly" untuk produk ramah lingkungan (SDG 12).
class EcoFriendlyBadge extends StatelessWidget {
  const EcoFriendlyBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: CraftSpacing.md,
        vertical: CraftSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(CraftRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.eco, size: 16, color: colorScheme.onPrimaryContainer),
          const SizedBox(width: CraftSpacing.xs),
          Text(
            'Eco-Friendly',
            style: textTheme.labelMedium?.copyWith(
              color: colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}

/// Badge kecil untuk label SDG, contoh: "SDG 8".
class SdgBadge extends StatelessWidget {
  final String label;

  const SdgBadge({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: CraftSpacing.md,
        vertical: CraftSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(CraftRadius.pill),
      ),
      child: Text(
        label,
        style: textTheme.labelMedium?.copyWith(color: colorScheme.onPrimary),
      ),
    );
  }
}

/// Pil informasi berisi ikon dan teks, contoh: bintang + rating.
class InfoPill extends StatelessWidget {
  final IconData icon;
  final String label;

  const InfoPill({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: CraftSpacing.md,
        vertical: CraftSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(CraftRadius.pill),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: colorScheme.primary),
          const SizedBox(width: CraftSpacing.xs),
          Text(label, style: textTheme.labelMedium),
        ],
      ),
    );
  }
}

/// Kontainer informasi: kartu putih bergaris dengan judul dan isi.
/// Dipakai untuk bagian Informasi Perajin, Detail Produk, dan Tentang Produk.
class InfoContainer extends StatelessWidget {
  final String title;
  final Widget child;

  const InfoContainer({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(
        CraftSpacing.lg,
        0,
        CraftSpacing.lg,
        CraftSpacing.md,
      ),
      padding: const EdgeInsets.all(CraftSpacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(CraftRadius.md),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: textTheme.titleMedium),
          const SizedBox(height: CraftSpacing.md),
          child,
        ],
      ),
    );
  }
}

/// Satu baris rincian: ikon, label, dan nilai. Dipakai di dalam InfoContainer.
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: CraftSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: colorScheme.primary),
          const SizedBox(width: CraftSpacing.sm),
          Text(
            '$label: ',
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
