import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  // Variabel untuk menerima data yang berbeda-beda tiap produk
  final String imageUrl;
  final String title;
  final String price;
  final int quantity;

  const CartItemWidget({
    super.key,
    required this.title,
    required this.price,
    required this.quantity,
    required this.imageUrl, // Sementara berupa warna atau ikon (placeholder)
  });

  @override
  Widget build(BuildContext context) {
    // Materi 4: Material 3 & Visual Design Systems
    // Menggunakan Card agar komponen produk terlihat rapi dan memiliki jarak
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        // Materi 1: Basic UI Layout
        // Row digunakan untuk menyusun gambar di kiri dan detail di kanan
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Produk (Placeholder visual)
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.brown.shade100, // Warna dummy untuk produk
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.image, color: Colors.brown),
            ),
            const SizedBox(width: 16),
            
            // Detail Produk (Nama, Harga, dan Kontrol)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Materi 3: Text & Rich Controls
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Baris untuk kontrol jumlah barang (-/+) dan tombol hapus
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Kontrol Jumlah Barang
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, size: 16),
                              onPressed: () {},
                              constraints: const BoxConstraints(),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            ),
                            Text(
                              quantity.toString(),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, size: 16),
                              onPressed: () {},
                              constraints: const BoxConstraints(),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            ),
                          ],
                        ),
                      ),
                      // Tombol Hapus (Ikon tempat sampah)
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.grey),
                        onPressed: () {},
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}