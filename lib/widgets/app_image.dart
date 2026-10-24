import 'package:flutter/material.dart';

/// Gambar dari asset yang memenuhi ruang induknya.
///
/// [path] boleh dengan ekstensi ('assets/images/a.jpg') atau TANPA ekstensi
/// ('assets/images/a'). Kalau tanpa ekstensi, otomatis dicoba .jpg, .jpeg,
/// .png, lalu .webp, jadi format file apa pun yang kamu pakai tetap ketemu.
///
/// Kalau [path] kosong atau filenya tidak ada, tampil placeholder abu-abu
/// sehingga aplikasi tidak error saat gambar belum tersedia.
class AppImage extends StatelessWidget {
  final String? path;
  final IconData placeholderIcon;

  const AppImage({
    super.key,
    required this.path,
    this.placeholderIcon = Icons.image_outlined,
  });

  static const List<String> _extensions = ['jpg', 'jpeg', 'png', 'webp'];
  static final RegExp _hasExtension = RegExp(
    r'\.(jpg|jpeg|png|webp|gif|bmp)$',
    caseSensitive: false,
  );

  List<String> _candidates(String p) {
    if (_hasExtension.hasMatch(p)) return [p];
    return [for (final ext in _extensions) '$p.$ext'];
  }

  // Coba satu per satu; kalau gagal lanjut ke kandidat berikutnya
  Widget _tryLoad(List<String> candidates, int index, Widget placeholder) {
    return Image.asset(
      candidates[index],
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        final next = index + 1;
        if (next < candidates.length) {
          return _tryLoad(candidates, next, placeholder);
        }
        return placeholder;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      color: Colors.grey.shade300,
      alignment: Alignment.center,
      child: Icon(placeholderIcon, color: Colors.grey.shade500, size: 32),
    );

    final p = path;
    if (p == null || p.isEmpty) return placeholder;

    return _tryLoad(_candidates(p), 0, placeholder);
  }
}
