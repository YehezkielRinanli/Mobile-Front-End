import 'package:flutter/material.dart';
import '../widgets/notification_tile_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Materi 4: Scaffold sebagai kerangka dasar antarmuka
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Notifikasi',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () {},
        ),
      ),
      // Materi 1: Susunan dasar UI menggunakan ListView
      body: ListView(
        children: const [
          NotificationTileWidget(
            title: 'Pesanan Berhasil Dibuat',
            message: 'Pesanan Tas Rotan Anyaman Anda telah diterima dan sedang diproses oleh pengrajin Ibu Siti Aminah.',
            time: 'Baru saja',
            icon: Icons.check_circle_outline,
            isUnread: true, // Notifikasi baru
          ),
          Divider(height: 1, color: Colors.black12),
          NotificationTileWidget(
            title: 'Promo Khusus Bumi Hijau',
            message: 'Dapatkan diskon 10% untuk semua produk keramik lokal ramah lingkungan hari ini!',
            time: '2 jam yang lalu',
            icon: Icons.local_offer_outlined,
          ),
          Divider(height: 1, color: Colors.black12),
          NotificationTileWidget(
            title: 'Pesanan Dikirim',
            message: 'Pesanan Anyaman Bambu Anda telah diserahkan kepada kurir logistik.',
            time: 'Kemarin',
            icon: Icons.local_shipping_outlined,
          ),
        ],
      ),
    );
  }
}