import 'package:flutter/material.dart';
import 'profile_colors.dart';
import 'responsive_body.dart';

/// Kerangka halaman anak: Scaffold + AppBar + isi yang bisa di-scroll.
/// Tombol kembali pada AppBar muncul otomatis dari Navigator.
class SubPage extends StatelessWidget {
  final String title;
  final Widget child;

  const SubPage({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final c = PColors.of(context);
    final bg = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: c.heading),
        ),
        backgroundColor: bg,
        foregroundColor: c.heading,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ResponsiveBody(
          maxWidth: 720,
          child: child,
        ),
      ),
    );
  }
}
