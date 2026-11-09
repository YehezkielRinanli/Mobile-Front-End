import 'package:flutter/material.dart';
import '../widgets/info_row.dart';
import '../widgets/profile_colors.dart';
import '../widgets/section_card.dart';
import '../widgets/sub_page.dart';

// StatefulWidget dipakai karena metode utama bisa diganti.
class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

/// Metode pembayaran (halaman Metode Pembayaran).
/// Ketuk satu metode untuk menjadikannya metode utama.
class _PaymentPageState extends State<PaymentPage> {
  // Nomor metode yang menjadi utama.
  int _mainIndex = 0;

  static const List<Map<String, dynamic>> _methods = [
    {
      'name': 'Transfer Bank',
      'detail': 'Transfer melalui rekening bank',
      'icon': Icons.account_balance_outlined,
    },
    {
      'name': 'QRIS',
      'detail': 'Scan kode QR dengan aplikasi bank atau e-wallet',
      'icon': Icons.qr_code_2,
    },
    {
      'name': 'E-Wallet',
      'detail': 'Pembayaran melalui dompet digital',
      'icon': Icons.account_balance_wallet_outlined,
    },
    {
      'name': 'COD',
      'detail': 'Bayar saat pesanan diterima',
      'icon': Icons.local_shipping_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final c = PColors.of(context);

    return SubPage(
      title: 'Metode Pembayaran',
      child: SectionCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ketuk metode untuk menjadikannya utama.',
              style: TextStyle(fontSize: 12, color: c.secondary),
            ),
            const SizedBox(height: 8),
            for (int i = 0; i < _methods.length; i++) ...[
              if (i > 0) Divider(color: c.border),
              // Pemilihan metode utama merupakan pengubahan preferensi pembayaran.
              // Indikator pilihan dibuat dengan Icon, bukan widget Radio M11.
              // Kontrol yang sudah ada ini dipertahankan tanpa menambah widget M11.
              // ===== M09 (User Interaction) - MULAI =====
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    _mainIndex = i;
                  });
                },
                // ===== M09 - SELESAI =====
                child: InfoRow(
                  icon: _methods[i]['icon'] as IconData,
                  label: _methods[i]['detail'] as String,
                  value: _methods[i]['name'] as String,
                  trailing: Icon(
                    i == _mainIndex
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: i == _mainIndex ? c.primary : c.secondary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
