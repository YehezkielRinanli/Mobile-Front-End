/// 350000 -> "Rp 350.000"
String formatRupiah(int value) {
  final digits = value.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('.');
    buffer.write(digits[i]);
  }
  return 'Rp $buffer';
}

/// 1200 -> "1.2k", 85 -> "85"
String formatCount(int count) {
  if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}k';
  return '$count';
}
