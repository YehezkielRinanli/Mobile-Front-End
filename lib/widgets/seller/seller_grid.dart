import 'package:flutter/material.dart';

import '../../core/constants/app_breakpoints.dart';
import '../../core/constants/app_spacing.dart';
import '../../models/seller.dart';
import 'seller_card.dart';

class SellerGrid extends StatelessWidget {
  final List<Seller> sellers;
  final ValueChanged<Seller> onSellerTap;

  const SellerGrid({
    super.key,
    required this.sellers,
    required this.onSellerTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    // 1 kolom di HP, 2 kolom di layar besar, 3 kolom di layar sangat besar
    int columns = 1;
    if (screenWidth >= AppBreakpoints.extraWide) {
      columns = 3;
    } else if (screenWidth >= AppBreakpoints.wide) {
      columns = 2;
    }

    // Tinggi kartu mengikuti ukuran huruf yang dipilih pengguna,
    // supaya teks yang membesar tidak keluar dari kartu.
    final textScale = MediaQuery.textScalerOf(context).scale(1);

    return GridView.builder(
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: sellers.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        mainAxisExtent: 96 * (textScale < 1 ? 1 : textScale),
      ),
      itemBuilder: (context, index) {
        final seller = sellers[index];
        return SellerCard(
          seller: seller,
          onTap: () => onSellerTap(seller),
        );
      },
    );
  }
}