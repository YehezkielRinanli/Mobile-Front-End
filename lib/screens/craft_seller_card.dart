import 'package:flutter/material.dart';

import '../models/seller.dart';
import 'craft_components.dart';
import 'craft_theme.dart';

/// Custom Reusable Widget: kartu perajin di halaman produk (Tahap 3).
///
/// Menampilkan foto, nama, toko, dan rating perajin. Seluruh kartu bisa
/// diketuk, dan ada tombol "Lihat Profil Perajin" sebagai gerbang ke halaman
/// profil perajin. Widget ini hanya memanggil [onOpenProfile]; urusan
/// berpindah halaman ada di layar yang memakainya.
class SellerGateCard extends StatelessWidget {
  final Seller seller;
  final VoidCallback onOpenProfile;

  const SellerGateCard({
    super.key,
    required this.seller,
    required this.onOpenProfile,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onOpenProfile,
      child: InfoContainer(
        title: 'Informasi Perajin',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _SellerAvatar(seller: seller),
                const SizedBox(width: CraftSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        seller.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleSmall,
                      ),
                      Text(
                        seller.shopName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: CraftSpacing.xs),
                      InfoPill(
                        icon: Icons.star,
                        label: '${seller.rating.toStringAsFixed(1)} Rating Toko',
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
              ],
            ),
            const SizedBox(height: CraftSpacing.md),
            SizedBox(
              width: double.infinity,
              child: FilledButton.tonalIcon(
                onPressed: onOpenProfile,
                icon: const Icon(Icons.storefront_outlined),
                label: const Text('Lihat Profil Perajin'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Foto bulat perajin. Jika tidak ada foto, tampil huruf pertama nama.
class _SellerAvatar extends StatelessWidget {
  final Seller seller;

  const _SellerAvatar({required this.seller});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final initial = seller.name.isNotEmpty ? seller.name[0] : '?';

    final fallback = Container(
      color: colorScheme.primaryContainer,
      alignment: Alignment.center,
      child: Text(
        initial,
        style: textTheme.titleLarge?.copyWith(
          color: colorScheme.onPrimaryContainer,
        ),
      ),
    );

    return ClipOval(
      child: SizedBox(
        width: 56,
        height: 56,
        child: seller.photo.isEmpty
            ? fallback
            : Image.asset(
                seller.photo,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => fallback,
              ),
      ),
    );
  }
}
