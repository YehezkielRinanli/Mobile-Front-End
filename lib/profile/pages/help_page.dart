import 'package:flutter/material.dart';
import '../widgets/profile_colors.dart';
import '../widgets/section_card.dart';
import '../widgets/sub_page.dart';

// StatefulWidget dipakai karena jawaban FAQ bisa dibuka dan ditutup.
class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

/// Pusat bantuan (halaman Pusat Bantuan).
class _HelpPageState extends State<HelpPage> {
    // Nomor FAQ yang sedang terbuka.
  final Set<int> _openFaq = {};
  
  static const List<Map<String, String>> _faqItems = [
    {
      'question': 'Bagaimana cara melihat pesanan saya?',
      'answer':
          'Buka menu Profil Saya, lalu pilih Pesanan Saya. '
          'Kamu dapat melihat daftar pesanan beserta statusnya.',
    },
    {
      'question': 'Bagaimana cara mengubah alamat pengiriman?',
      'answer':
          'Buka menu Alamat Saya. Pilih Edit untuk mengubah '
          'informasi alamat atau Tambah Alamat untuk menambahkan '
          'alamat baru.',
    },
    {
      'question': 'Metode pembayaran apa saja yang tersedia?',
      'answer':
          'Buka menu Metode Pembayaran. Tersedia Transfer Bank, '
          'QRIS, E-Wallet, dan COD. Pilih Jadikan utama untuk '
          'menetapkan metode yang paling sering kamu gunakan.',
    },
    {
      'question': 'Bagaimana cara mengubah foto profil?',
      'answer':
          'Buka halaman Profil Saya, tekan foto profil atau '
          'Ubah Foto Profil, kemudian pilih salah satu foto '
          'yang tersedia.',
    },
    {
      'question': 'Bagaimana cara mengubah tema aplikasi?',
      'answer':
          'Buka menu Pengaturan, lalu pilih Light Mode atau '
          'Dark Mode sesuai kenyamananmu.',
    },
    {
      'question': 'Apakah produk CraftOrigin merupakan produk lokal?',
      'answer':
          'CraftOrigin dirancang untuk menampilkan produk '
          'kerajinan lokal dan membantu pengguna mengenal '
          'karya para perajin Indonesia.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final c = PColors.of(context);

    return SubPage(
      title: 'Pusat Bantuan',
      child: SectionCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < _faqItems.length; i++) ...[
              if (i > 0) Divider(color: c.border),
              // ===== M09 (User Interaction) - MULAI =====
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                                    setState(() {
                    if (_openFaq.contains(i)) {
                      _openFaq.remove(i);
                    } else {
                      _openFaq.add(i);
                    }
                  });
                                  },
                // ===== M09 - SELESAI =====
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              _faqItems[i]['question']!,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: c.heading,
                              ),
                            ),
                          ),
                          Icon(
                            _openFaq.contains(i)
                                ? Icons.expand_less
                                : Icons.expand_more,
                            color: c.primary,
                          ),
                        ],
                      ),
                      if (_openFaq.contains(i)) ...[
                        const SizedBox(height: 6),
                        Text(
                          _faqItems[i]['answer']!,
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.4,
                            color: c.secondary,
                          ),
                        ),
                      ],
                    ],
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
