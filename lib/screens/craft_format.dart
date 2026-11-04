/// Mengubah angka rupiah menjadi teks berformat, contoh: 150000 menjadi
/// "Rp 150.000". Titik ditambahkan setiap tiga digit dari belakang.
String formatPrice(int amount) {
  final digits = amount.toString();
  final buffer = StringBuffer();

  for (var i = 0; i < digits.length; i++) {
    final remaining = digits.length - i;
    buffer.write(digits[i]);
    // Beri titik jika sisa digit setelahnya kelipatan tiga.
    if (remaining > 1 && remaining % 3 == 1) {
      buffer.write('.');
    }
  }

  return 'Rp $buffer';
}
