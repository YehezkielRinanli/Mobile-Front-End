import 'package:flutter/material.dart';
import '../../notification/screens/notification_screen.dart';

const Color craftOriginGreen = Color(0xFF204E38);

class OrderSuccessDialog extends StatelessWidget {
  final String totalAmount;

  const OrderSuccessDialog({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: craftOriginGreen, size: 64),
            const SizedBox(height: 16),
            const Text('Pesanan Berhasil!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
                children: [
                  const TextSpan(text: 'Anda berhasil menyelesaikan pembayaran dengan total '),
                  TextSpan(text: totalAmount, style: const TextStyle(fontWeight: FontWeight.bold, color: craftOriginGreen, fontSize: 16)),
                  const TextSpan(text: '.\nPengrajin akan segera memproses pesanan Anda.'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: craftOriginGreen,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  Navigator.pop(context); // Menutup dialog
                  // Membuka halaman notifikasi
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationScreen(),
                    ),
                  );
                },
                child: const Text('Lihat Notifikasi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}