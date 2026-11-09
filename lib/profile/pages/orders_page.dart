import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../widgets/profile_colors.dart';
import '../widgets/section_card.dart';
import '../widgets/sub_page.dart';

/// Daftar pesanan (halaman Pesanan Saya).
/// Semua pesanan ditampilkan; status ditandai kotak berwarna.
// StatefulWidget dipakai karena filter status harus bisa berubah.
class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
    // Filter status yang sedang dipilih.
  String _selectedStatus = 'Semua';
  
  static const List<String> _statuses = [
    'Semua',
    'Belum Bayar',
    'Diproses',
    'Dikirim',
    'Selesai',
    'Dibatalkan',
  ];

  static const List<Map<String, dynamic>> _orders = [
    {
      'id': 'CO-20261001',
      'name': 'Tas Anyaman Rotan Khas',
      'seller': 'Ibu Siti, Bali',
      'price': 150000,
      'date': '20 Okt 2026',
      'status': 'Belum Bayar',
      'icon': Icons.shopping_bag_outlined,
    },
    {
      'id': 'CO-20261002',
      'name': 'Vas Keramik Handmade',
      'seller': 'Bapak Made, Yogyakarta',
      'price': 85000,
      'date': '19 Okt 2026',
      'status': 'Diproses',
      'icon': Icons.local_florist_outlined,
    },
    {
      'id': 'CO-20261003',
      'name': 'Hiasan Dinding Anyaman',
      'seller': 'Ibu Rina, Lombok',
      'price': 120000,
      'date': '18 Okt 2026',
      'status': 'Dikirim',
      'icon': Icons.home_outlined,
    },
    {
      'id': 'CO-20261004',
      'name': 'Keranjang Anyaman Bambu',
      'seller': 'Pak Joko, Medan',
      'price': 95000,
      'date': '15 Okt 2026',
      'status': 'Selesai',
      'icon': Icons.shopping_basket_outlined,
    },
    {
      'id': 'CO-20261005',
      'name': 'Gantungan Kunci Kayu',
      'seller': 'Ibu Rina, Lombok',
      'price': 35000,
      'date': '14 Okt 2026',
      'status': 'Dibatalkan',
      'icon': Icons.key_outlined,
    },
  ];

  String _formatPrice(int price) {
    final value = price.toString();
    final result = StringBuffer();
    for (int i = 0; i < value.length; i++) {
      if (i > 0 && (value.length - i) % 3 == 0) {
        result.write('.');
      }
      result.write(value[i]);
    }
    return 'Rp$result';
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Belum Bayar':
        return Colors.orange;
      case 'Diproses':
        return Colors.blue;
      case 'Dikirim':
        return Colors.indigo;
      case 'Dibatalkan':
        return AppColors.terracotta;
      default:
        return AppColors.primaryGreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = PColors.of(context);

    // Daftar pesanan sesuai filter yang dipilih.
    final orders = _selectedStatus == 'Semua'
        ? _orders
        : _orders.where((o) => o['status'] == _selectedStatus).toList();

    return SubPage(
      title: 'Pesanan Saya',
      child: SectionCard(
      child: Column(
        children: [
                    // Pilihan filter status: Container + GestureDetector.
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final status in _statuses)
                // ===== M09 (User Interaction) - MULAI =====
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedStatus = status;
                    });
                  },
                  // ===== M09 - SELESAI =====
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _selectedStatus == status
                          ? c.primary
                          : c.soft,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 12,
                        color: _selectedStatus == status
                            ? c.onPrimary
                            : c.heading,
                      ),
                    ),
                  ),
                ),
            ],
          ),
                    const SizedBox(height: 12),
          if (orders.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Belum ada pesanan dengan status ini.',
                style: TextStyle(color: c.secondary),
              ),
            ),
          for (int i = 0; i < orders.length; i++) ...[
            if (i > 0) Divider(color: c.border),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: c.soft,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(orders[i]['icon'] as IconData,
                        color: c.primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orders[i]['name'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: c.heading,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${orders[i]['seller']} • ${orders[i]['date']}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12, color: c.secondary),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _formatPrice(orders[i]['price'] as int),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: c.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _statusColor(orders[i]['status'] as String)
                          .withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      orders[i]['status'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _statusColor(orders[i]['status'] as String),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    ));
  }
}
