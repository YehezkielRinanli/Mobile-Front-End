import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../app_image.dart';

class ProductImage extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;

  const ProductImage({
    super.key,
    required this.imagePath,
    this.width = 200,
    this.height = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: AppImage(
        path: imagePath,
      ),
    );
  }
}