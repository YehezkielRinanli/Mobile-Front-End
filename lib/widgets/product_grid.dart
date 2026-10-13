import 'package:flutter/material.dart';

/// Grid 2 kolom dengan jarak seragam untuk kartu produk.
/// Dibuat untuk diletakkan DI DALAM halaman yang sudah bisa di-scroll
/// (SingleChildScrollView), jadi grid ini sendiri tidak ikut scroll.
///
/// Contoh:
/// ProductGrid(
///   itemCount: products.length,
///   itemBuilder: (context, i) => ProductGridCard(...),
/// )
class ProductGrid extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  /// Tinggi tiap kartu. Naikkan kalau kartunya memuat lebih banyak baris.
  final double itemHeight;

  const ProductGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.itemHeight = 250,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        mainAxisExtent: itemHeight,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
