import 'package:flutter/material.dart';

import 'craft_theme.dart';

/// Custom Reusable Widget: galeri foto produk (Tahap 3).
///
/// Foto besar bersudut membulat. Di atasnya (Stack) ada tombol kembali,
/// bagikan, favorit, dan penanda halaman "1/4". Di bawahnya ada deretan
/// thumbnail yang bisa digeser (ListView horizontal).
class ProductPhotoGallery extends StatelessWidget {
  final List<String> photos;
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  final VoidCallback onShare;
  final VoidCallback onBack;

  const ProductPhotoGallery({
    super.key,
    required this.photos,
    required this.selectedIndex,
    required this.onSelect,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.onShare,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 1.1,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(CraftRadius.lg),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                _GalleryPhoto(path: photos[selectedIndex]),
                Positioned(
                  top: CraftSpacing.md,
                  left: CraftSpacing.md,
                  child: _CircleIconButton(
                    icon: Icons.arrow_back,
                    label: 'Kembali',
                    onTap: onBack,
                  ),
                ),
                Positioned(
                  top: CraftSpacing.md,
                  right: CraftSpacing.md,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _CircleIconButton(
                        icon: Icons.share_outlined,
                        label: 'Bagikan',
                        onTap: onShare,
                      ),
                      const SizedBox(width: CraftSpacing.sm),
                      _CircleIconButton(
                        icon: isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        label: 'Favorit',
                        color: isFavorite ? colorScheme.error : null,
                        onTap: onToggleFavorite,
                      ),
                    ],
                  ),
                ),
                if (photos.length > 1)
                  Positioned(
                    right: CraftSpacing.md,
                    bottom: CraftSpacing.md,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: CraftSpacing.md,
                        vertical: CraftSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.scrim.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(CraftRadius.pill),
                      ),
                      child: Text(
                        '${selectedIndex + 1}/${photos.length}',
                        style: textTheme.labelMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (photos.length > 1) ...[
          const SizedBox(height: CraftSpacing.md),
          SizedBox(
            height: 64,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: photos.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: CraftSpacing.sm),
              itemBuilder: (context, index) {
                final isSelected = index == selectedIndex;
                return GestureDetector(
                  onTap: () => onSelect(index),
                  child: Container(
                    width: 64,
                    height: 64,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(CraftRadius.sm),
                      border: Border.all(
                        color: isSelected
                            ? colorScheme.primary
                            : colorScheme.outlineVariant,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: _GalleryPhoto(path: photos[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}

/// Foto dari aset lokal. Jika berkas tidak ada, tampil ikon cadangan.
class _GalleryPhoto extends StatelessWidget {
  final String path;

  const _GalleryPhoto({required this.path});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Image.asset(
      path,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, __, ___) => Align(
        alignment: Alignment.center,
        child: Icon(
          Icons.image_outlined,
          size: 48,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

/// Tombol ikon bulat putih yang diletakkan di atas foto.
class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _CircleIconButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: label,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLowest,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: color ?? colorScheme.onSurface),
        ),
      ),
    );
  }
}
