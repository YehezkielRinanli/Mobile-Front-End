import 'package:flutter/material.dart';

// Menggunakan warna utama CraftOrigin
const Color craftOriginGreen = Color(0xFF204E38);

class NotificationTileWidget extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final IconData icon;
  final bool isUnread;

  const NotificationTileWidget({
    super.key,
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    this.isUnread = false,
  });

  @override
  Widget build(BuildContext context) {
    // Materi 4: Menggunakan desain Material 3 (Container & ListTile)
    return Container(
      // Latar belakang sedikit hijau jika notifikasi belum dibaca
      color: isUnread ? craftOriginGreen.withOpacity(0.05) : Colors.transparent,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        // Materi 3: Visual Avatar untuk ikon notifikasi
        leading: CircleAvatar(
          backgroundColor: craftOriginGreen.withOpacity(0.1),
          child: Icon(icon, color: craftOriginGreen),
        ),
        // Materi 3: Text & Rich Controls
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(message, style: const TextStyle(fontSize: 14, color: Colors.black87)),
            const SizedBox(height: 6),
            Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}