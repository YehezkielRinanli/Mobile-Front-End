import 'package:flutter/material.dart';

const Color craftOriginGreen = Color(0xFF204E38);

class OrderSuccessDialog extends StatelessWidget {
  // Data statis sementara sebelum kita menggunakan State Management (Materi 7)
  final String productName = "Tas Rotan Anyaman";
  final String artisanName = "Ibu Siti Aminah";
  final String totalPrice = "Rp 150.000";

  const OrderSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // Materi 4: Menggunakan komponen Dialog bawaan Material 3
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        // Materi 1: Basic UI Layout (Menyusun elemen dari atas ke bawah)
        child: Column(
          mainAxisSize: MainAxisSize.min, // Agar tinggi pop-up menyesuaikan isinya
          children: [
            const Icon(
              Icons.check_circle,
              color: craftOriginGreen,
              size: 64,
            ),
            const SizedBox(height: 16),
            const Text(
              'Pesanan Berhasil!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Materi 3: Text & Rich Controls 
            // Menggabungkan gaya teks yang berbeda dalam satu paragraf
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
                children: [
                  const TextSpan(text: 'Anda berhasil membeli produk '),
                  TextSpan(
                    text: productName, 
                    style: const TextStyle(fontWeight: FontWeight.bold)
                  ),
                  const TextSpan(text: '\ndari pengrajin '),
                  TextSpan(
                    text: artisanName, 
                    style: const TextStyle(fontWeight: FontWeight.bold)
                  ),
                  const TextSpan(text: '\ndengan total harga '),
                  TextSpan(
                    text: totalPrice, 
                    style: const TextStyle(fontWeight: FontWeight.bold, color: craftOriginGreen, fontSize: 16)
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Materi 4: Material 3 Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: craftOriginGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  // Nanti akan diisi logika untuk pindah ke halaman Notifikasi
                  Navigator.of(context).pop(); // Menutup dialog
                },
                child: const Text(
                  'Lihat Notifikasi',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}