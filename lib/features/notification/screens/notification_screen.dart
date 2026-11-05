import 'package:flutter/material.dart';

const Color craftOriginGreen = Color(0xFF204E38);

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Notifikasi', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      // Pertemuan 6: ListView
      body: ListView(
        children: [
          _buildNotificationItem(
            title: 'Pesanan Berhasil',
            productName: 'Tas Rotan Anyaman',
            artisanName: 'Ibu Siti Aminah',
            icon: Icons.check_circle,
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }

  // Komponen pembantu untuk list notifikasi
  Widget _buildNotificationItem({
    required String title,
    required String productName,
    required String artisanName,
    required IconData icon,
  }) {
    return Padding(
      // Pertemuan 5: Padding
      padding: const EdgeInsets.all(16.0),
      // Pertemuan 6: Row
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pertemuan 3: Circle Avatar
          CircleAvatar(
            backgroundColor: craftOriginGreen.withOpacity(0.1),
            child: Icon(icon, color: craftOriginGreen),
          ),
          const SizedBox(width: 16),
          // Pertemuan 6: Expanded
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                // Pertemuan 3: Rich Text (Menggabungkan teks biasa dengan teks tebal)
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
                    children: [
                      const TextSpan(text: 'Anda berhasil membeli produk '),
                      TextSpan(text: productName, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const TextSpan(text: ' dari pengrajin '),
                      TextSpan(text: artisanName, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const TextSpan(text: '.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}