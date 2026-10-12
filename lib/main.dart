import 'package:flutter/material.dart';

import 'features/notification/screens/notification_screen.dart';

// import 'features/checkout/screens/checkout_screen.dart'; // Mengimpor layar checkout yang sudah dibuat

void main() {
  runApp(const CraftOriginApp());
}

class CraftOriginApp extends StatelessWidget {
  const CraftOriginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CraftOrigin',
      debugShowCheckedModeBanner: false, // Menghilangkan pita "DEBUG"
      theme: ThemeData(
        // Constraint warna utama (Hijau Gelap organik)
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2A5940)),
        useMaterial3: true,
        fontFamily: 'Roboto', // Bisa diganti jika nanti ada custom font
      ),
      home: const NotificationScreen(), // Mengarahkan ke layar checkout untuk saat ini
    );
  }
}
