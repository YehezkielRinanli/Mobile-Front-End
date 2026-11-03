import 'package:flutter/material.dart';

import '../../core/constants/app_breakpoints.dart';
import '../../core/constants/app_spacing.dart';
import '../../models/seller.dart';
import 'contact_label.dart';
import 'rating_info.dart';
import 'seller_avatar.dart';
import 'shop_tag.dart';

class SellerHeader extends StatelessWidget {
  final String imagePath;
  final String name;
  final String shopName;
  final String email;
  final String phone;
  final String city;
  final String rating;
  final String reviewCount;

  const SellerHeader({
    super.key,
    required this.imagePath,
    required this.name,
    required this.shopName,
    this.email = 'kontak@perajin.id',
    this.phone = '0812-3456-7890',
    required this.city,
    this.rating = '4.8',
    this.reviewCount = '120',
  });

  factory SellerHeader.fromSeller({
    Key? key,
    required Seller seller,
  }) {
    return SellerHeader(
      key: key,
      imagePath: seller.photo,
      name: seller.name,
      shopName: seller.shopName,
      city: seller.location,
      rating: seller.rating.toStringAsFixed(1),
      reviewCount: seller.products.length.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final screenWidth = MediaQuery.sizeOf(context).width;
    final isWide = screenWidth >= AppBreakpoints.wide;
    final avatarRadius = isWide ? 64.0 : 40.0;

    final emailLabel = ContactLabel(
      icon: Icons.email,
      label: 'Email',
      value: email,
    );
    final phoneLabel = ContactLabel(
      icon: Icons.phone,
      label: 'No. Telepon',
      value: phone,
    );
    final cityLabel = ContactLabel(
      icon: Icons.location_on,
      label: 'Kota',
      value: city,
    );

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SellerAvatar(imagePath: imagePath, radius: avatarRadius),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    ShopTag(name: shopName),
                    const SizedBox(height: AppSpacing.xs),
                    RatingInfo(rating: rating, reviewCount: reviewCount),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: emailLabel),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(flex: 3, child: phoneLabel),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(flex: 2, child: cityLabel),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    emailLabel,
                    phoneLabel,
                    cityLabel,
                  ],
                ),
        ],
      ),
    );
  }
}