import 'package:flutter/material.dart';

import '../models/seller.dart';
import '../theme/app_colors.dart';
import 'app_image.dart';
import 'pill_button.dart';

/// Kartu identitas perajin: foto, nama, toko, dan tombol aksi.
/// Semua aksi dikirim lewat callback, jadi kartu ini tidak tahu
/// apa-apa soal navigasi dan aman dipakai di halaman mana pun.
class SellerHeaderCard extends StatelessWidget {
  final Seller seller;
  final bool isFollowing;
  final VoidCallback? onFollowTap;
  final VoidCallback? onEmailTap;
  final VoidCallback? onPhoneTap;

  const SellerHeaderCard({
    super.key,
    required this.seller,
    this.isFollowing = false,
    this.onFollowTap,
    this.onEmailTap,
    this.onPhoneTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Foto perajin dengan cincin terakota
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.terracotta, width: 2.5),
            ),
            child: ClipOval(
              child: SizedBox(
                width: 72,
                height: 72,
                child: AppImage(
                  path: seller.photo,
                  placeholderIcon: Icons.person,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Nama, toko, dan tombol aksi
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  seller.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.cream,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.storefront,
                        size: 18,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          seller.shopName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Wrap: kalau layar sempit, tombol turun ke baris berikutnya
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    PillButton(
                      icon: Icons.email_outlined,
                      label: seller.email,
                      onTap: onEmailTap,
                    ),
                    PillButton(
                      icon: Icons.phone,
                      label: seller.phone,
                      onTap: onPhoneTap,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Lebar & tinggi tetap: saat ditekan hanya warna dan teks yang berubah
                _buildFollowButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFollowButton() {
    return SizedBox(
      width: double.infinity, // Selalu selebar kolomnya
      height: kPillHeight, // Sama tinggi dengan tombol email & telepon
      child: ElevatedButton.icon(
        onPressed: onFollowTap,
        icon: Icon(isFollowing ? Icons.check : Icons.add, size: 16),
        label: Text(isFollowing ? 'Mengikuti' : 'Ikuti'),
        style: ElevatedButton.styleFrom(
          backgroundColor: isFollowing
              ? AppColors.lightGreen
              : AppColors.primaryGreen,
          foregroundColor: isFollowing ? AppColors.primaryGreen : Colors.white,
          elevation: 0,
          minimumSize: Size.zero, // Biar tinggi ditentukan SizedBox di atas
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          // Garis tepi selalu ada di kedua kondisi, jadi ukuran tidak bergeser
          side: BorderSide(
            color: isFollowing
                ? AppColors.lightGreenBorder
                : AppColors.primaryGreen,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
