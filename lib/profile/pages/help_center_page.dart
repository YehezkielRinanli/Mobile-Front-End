
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  static const List<Map<String, String>> faqItems = [
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
      'question': 'Bagaimana cara menambahkan produk ke Wishlist?',
      'answer':
          'Pilih produk yang kamu sukai, lalu tekan ikon hati '
          'jika fitur favorit tersedia pada halaman produk. '
          'Produk yang tersimpan akan muncul di Wishlist.',
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
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    final backgroundColor =
        Theme.of(context).scaffoldBackgroundColor;

    final cardColor =
        isDark ? Theme.of(context).cardColor : AppColors.card;

    final headingColor = isDark
        ? const Color(0xFFF1EFE9)
        : AppColors.darkGreen;

    final secondaryColor = isDark
        ? const Color(0xFFBEC8BE)
        : Colors.grey.shade700;

    final primaryColor = isDark
        ? const Color(0xFFA8C9A5)
        : AppColors.primaryGreen;

    final borderColor = isDark
        ? const Color(0xFF35463A)
        : AppColors.lightGreenBorder;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Pusat Bantuan',
          style: TextStyle(
            color: headingColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: backgroundColor,
        foregroundColor: headingColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // HEADER BANTUAN
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF263A2D)
                  : AppColors.lightGreen,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: borderColor,
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: cardColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.support_agent_outlined,
                    size: 38,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Ada yang bisa kami bantu?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: headingColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Temukan jawaban untuk pertanyaanmu '
                  'seputar penggunaan CraftOrigin.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: secondaryColor,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // DAFTAR FAQ
          Text(
            'Pertanyaan yang Sering Diajukan',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: headingColor,
            ),
          ),

          const SizedBox(height: 12),

          Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: borderColor,
              ),
            ),
            child: Column(
              children: [
                ...List.generate(faqItems.length, (index) {
                  final faq = faqItems[index];

                  return Column(
                    children: [
                      ExpansionTile(
                        key: PageStorageKey<String>(
                          faq['question']!,
                        ),
                        tilePadding:
                            const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        childrenPadding:
                            const EdgeInsets.fromLTRB(
                          16,
                          0,
                          16,
                          16,
                        ),
                        iconColor: primaryColor,
                        collapsedIconColor: secondaryColor,
                        title: Text(
                          faq['question']!,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: headingColor,
                          ),
                        ),
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              faq['answer']!,
                              style: TextStyle(
                                fontSize: 13,
                                height: 1.5,
                                color: secondaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (index < faqItems.length - 1)
                        Divider(
                          height: 1,
                          indent: 16,
                          endIndent: 16,
                          color: borderColor,
                        ),
                    ],
                  );
                }),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // KONTAK BANTUAN
          Text(
            'Butuh Bantuan Lain?',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: headingColor,
            ),
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: borderColor,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.email_outlined,
                  color: primaryColor,
                  size: 26,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hubungi Tim Bantuan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: headingColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Jika pertanyaanmu belum terjawab, '
                        'kamu dapat menghubungi tim bantuan '
                        'melalui kontak resmi CraftOrigin.',
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.5,
                          color: secondaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Kontak resmi belum dikonfigurasi.',
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: secondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
