import 'package:flutter/material.dart';

class SellerProduct {
  final String id;
  final String name;
  final String category;
  final String price;
  final String image;
  final String location;
  final String description;

  const SellerProduct({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
    required this.location,
    required this.description,
  });
}

class Seller {
  final String id;
  final String name;
  final String shopName;
  final String photo;
  final String location;
  final String bio;
  final double rating;
  final List<SellerProduct> products;

  const Seller({
    required this.id,
    required this.name,
    required this.shopName,
    required this.photo,
    required this.location,
    required this.bio,
    required this.rating,
    required this.products,
  });
}

// 4 Perajin lengkap dengan foto dari assets/images/
final List<Seller> dummySellers = [
  const Seller(
    id: 's1',
    name: 'Ibu Siti',
    shopName: 'Rumah Rotan',
    photo: 'assets/images/seller_siti_aminah.jpg',
    location: 'Bali',
    bio: 'Membuat kerajinan anyaman rotan ramah lingkungan sejak 2012.',
    rating: 4.9,
    products: [
      SellerProduct(
        id: 'p1',
        name: 'Tas Anyaman Rotan',
        category: 'Tas & Aksesori',
        price: 'Rp150.000',
        image: 'assets/images/product_tas_rotan_1.jpg',
        location: 'Bali',
        description: 'Tas anyaman rotan buatan tangan berkualitas tinggi.',
      ),
      SellerProduct(
        id: 'p2',
        name: 'Keranjang Rotan',
        category: 'Anyaman',
        price: 'Rp85.000',
        image: 'assets/images/product_tas_rotan_2.jpg',
        location: 'Bali',
        description: 'Keranjang serbaguna dari bahan alami.',
      ),
    ],
  ),
  const Seller(
    id: 's2',
    name: 'Pak Wayan',
    shopName: 'Gerabah Tirta',
    photo: 'assets/images/seller_wayan_sudarta.jpg',
    location: 'Lombok',
    bio: 'Perajin keramik dan gerabah tradisional khas Lombok.',
    rating: 4.8,
    products: [
      SellerProduct(
        id: 'p3',
        name: 'Vas Keramik Bumi',
        category: 'Keramik',
        price: 'Rp120.000',
        image: 'assets/images/product_keramik_1.jpg',
        location: 'Lombok',
        description: 'Vas keramik sentuhan tanah liat alami.',
      ),
    ],
  ),
  const Seller(
    id: 's3',
    name: 'Tenun Lestari',
    shopName: 'Galeri Tenun',
    photo: 'assets/images/product_tekstil_1.jpg',
    location: 'Sumba',
    bio: 'Menjaga kelestarian kain tenun ikat pewarna alam Sumba.',
    rating: 4.9,
    products: [
      SellerProduct(
        id: 'p4',
        name: 'Syal Tenun Alami',
        category: 'Pakaian',
        price: 'Rp95.000',
        image: 'assets/images/product_tekstil_1.jpg',
        location: 'Sumba',
        description: 'Kain tenun dengan motif khas dan warna alami.',
      ),
    ],
  ),
  const Seller(
    id: 's4',
    name: 'Studio Akar',
    shopName: 'Dekorasi Alami',
    photo: 'assets/images/product_tas_rotan_3.jpg',
    location: 'Bandung',
    bio: 'Kreator lampu meja dan dekorasi berbahan bambu & kayu.',
    rating: 4.7,
    products: [
      SellerProduct(
        id: 'p5',
        name: 'Lampu Meja Rotan',
        category: 'Dekorasi',
        price: 'Rp210.000',
        image: 'assets/images/product_tas_rotan_4.jpg',
        location: 'Bandung',
        description: 'Lampu meja minimalis estetis untuk ruangan.',
      ),
    ],
  ),
];