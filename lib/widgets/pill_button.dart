import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Tinggi tetap untuk tombol-tombol kecil di kartu profil
/// (email, telepon, dan Ikuti). Ubah angka ini kalau ingin
/// semuanya lebih tinggi atau lebih pendek sekaligus.
const double kPillHeight = 32;

/// Tombol kecil berbentuk pil (hijau muda) dengan ikon dan teks.
class PillButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const PillButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.lightGreen,
      shape: const StadiumBorder(
        side: BorderSide(color: AppColors.lightGreenBorder),
      ),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: SizedBox(
          height: kPillHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 15, color: AppColors.primaryGreen),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
