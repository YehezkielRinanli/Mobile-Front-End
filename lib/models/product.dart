import 'package:flutter/material.dart';

enum ProductCategory {
  tasAksesori('Tas & Aksesori', Icons.shopping_bag_outlined),
  dekorasi('Dekorasi', Icons.weekend_outlined),
  anyaman('Anyaman', Icons.grid_view_rounded),
  keramik('Keramik', Icons.dinner_dining_outlined),
  alatRumah('Alat Rumah', Icons.kitchen_outlined),
  pakaian('Pakaian', Icons.checkroom_outlined);

  final String label;
  final IconData icon;

  const ProductCategory(this.label, this.icon);
}

class Product {
  final String id;
  final String name;
  final int price;
  final double rating;
  final int reviewCount;
  final String location;
  final ProductCategory category;
  final String sellerId;
  final String sellerName;
  final String sellerRole;
  final String material;
  final String technique;
  final bool isEcoFriendly;
  final String description;
  final String? imageName;
  final int photoCount;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.location,
    required this.category,
    required this.sellerId,
    required this.sellerName,
    required this.sellerRole,
    required this.material,
    required this.technique,
    required this.description,
    this.isEcoFriendly = true,
    this.imageName,
    this.photoCount = 1,
  });

  String get _base => 'assets/images/product_${imageName ?? id}';
  String get image => photoCount > 1 ? '${_base}_1' : _base;
  List<String> get photos {
    if (photoCount <= 1) return [_base];
    return List.generate(photoCount, (i) => '${_base}_${i + 1}');
  }
}
