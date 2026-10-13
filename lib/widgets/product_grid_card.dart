import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/formatters.dart';
import 'app_image.dart';

/// Kartu produk untuk tampilan grid (katalog penjual, Explore, dll).
///
/// Sengaja menerima data biasa (bukan model), jadi bisa dipakai dari
/// model produk apa pun yang nanti disepakati tim. Rating, jumlah ulasan,
/// dan lokasi bersifat opsional: kalau tidak diisi, barisnya tidak tampil.
///
/// Contoh:
/// ProductGridCard(
///   name: 'Tas Rotan',
///   price: 150000,
///   image: 'assets/images/product_tas_rotan', // boleh tanpa ekstensi
///   rating: 4.8,
///   reviewCount: 120,
///   location: 'Sumatera Utara',
///   onTap: () { ... },
/// )
class ProductGridCard extends StatelessWidget {
  final String name;
  final int price; // Dalam rupiah, contoh: 150000
  final String? image;
  final double? rating;
  final int? reviewCount;
  final String? location;
  final VoidCallback? onTap;

  const ProductGridCard({
    super.key,
    required this.name,
    required this.price,
    this.image,
    this.rating,
    this.reviewCount,
    this.location,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Material + InkWell supaya efek sentuh (ripple) terlihat di atas kartu
    return Material(
      color: AppColors.card,
      elevation: 2,
      shadowColor: const Color(0x33000000),
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar mengisi sisa ruang, jadi aman kalau teks membesar
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: double.infinity,
                    child: AppImage(path: image),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    formatRupiah(price),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                  if (rating != null) ...[
                    const SizedBox(height: 4),
                    _buildRating(),
                  ],
                  if (location != null) ...[
                    const SizedBox(height: 2),
                    _buildLocation(),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Contoh tampil: ★ 4.6 (73)
  Widget _buildRating() {
    final count = reviewCount != null ? ' (${formatCount(reviewCount!)})' : '';
    return Row(
      children: [
        const Icon(Icons.star, size: 14, color: AppColors.star),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            '${rating!.toStringAsFixed(1)}$count',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
          ),
        ),
      ],
    );
  }

  /// Contoh tampil: 📍 Yogyakarta
  Widget _buildLocation() {
    return Row(
      children: [
        Icon(Icons.location_on_outlined, size: 14, color: Colors.grey.shade600),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            location!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
          ),
        ),
      ],
    );
  }
}
