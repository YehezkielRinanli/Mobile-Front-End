import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _statuses = [
    'Semua',
    'Belum Bayar',
    'Diproses',
    'Dikirim',
    'Selesai',
    'Dibatalkan',
  ];

  final List<Map<String, dynamic>> _orders = [
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

  bool get _isDark =>
      Theme.of(context).brightness == Brightness.dark;

  Color get _textColor => _isDark
      ? const Color(0xFFF1EFE9)
      : AppColors.darkGreen;

  Color get _secondaryColor =>
      _isDark ? const Color(0xFFBEC8BE) : Colors.grey.shade600;

  Color get _cardColor =>
      _isDark ? Theme.of(context).cardColor : AppColors.card;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _statuses.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
      case 'Selesai':
        return AppColors.primaryGreen;
      case 'Dibatalkan':
        return AppColors.terracotta;
      default:
        return AppColors.primaryGreen;
    }
  }

  List<Map<String, dynamic>> _getFilteredOrders(String status) {
    if (status == 'Semua') {
      return _orders;
    }

    return _orders
        .where((order) => order['status'] == status)
        .toList();
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    final status = order['status'] as String;
    final statusColor = _statusColor(status);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _isDark
              ? const Color(0xFF35463A)
              : AppColors.cream,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.receipt_long_outlined,
                size: 18,
                color: _secondaryColor,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  order['id'] as String,
                  style: TextStyle(
                    color: _textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                order['date'] as String,
                style: TextStyle(
                  color: _secondaryColor,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(color: _isDark ? const Color(0xFF35463A) : AppColors.cream),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: _isDark
                      ? const Color(0xFF29382F)
                      : AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  order['icon'] as IconData,
                  size: 32,
                  color: _isDark
                      ? const Color(0xFFA8C9A5)
                      : AppColors.primaryGreen,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order['name'] as String,
                      style: TextStyle(
                        color: _textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      order['seller'] as String,
                      style: TextStyle(
                        color: _secondaryColor,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      _formatPrice(order['price'] as int),
                      style: TextStyle(
                        color: _isDark
                            ? const Color(0xFFA8C9A5)
                            : AppColors.primaryGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Divider(color: _isDark ? const Color(0xFF35463A) : AppColors.cream),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: _isDark && status == 'Selesai'
                        ? const Color(0xFFA8C9A5)
                        : statusColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              if (status == 'Belum Bayar')
                OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Fitur pembayaran belum terhubung.',
                        ),
                      ),
                    );
                  },
                  child: const Text('Bayar'),
                ),
              if (status == 'Dikirim')
                OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Fitur pelacakan belum terhubung.',
                        ),
                      ),
                    );
                  },
                  child: const Text('Lacak Pesanan'),
                ),
              if (status == 'Selesai')
                OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Terima kasih telah berbelanja!',
                        ),
                      ),
                    );
                  },
                  child: const Text('Beli Lagi'),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList(String status) {
    final filteredOrders = _getFilteredOrders(status);

    if (filteredOrders.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.receipt_long_outlined,
                size: 54,
                color: _secondaryColor,
              ),
              const SizedBox(height: 12),
              Text(
                'Belum ada pesanan',
                style: TextStyle(
                  color: _textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Pesanan dengan status "$status" akan muncul di sini.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _secondaryColor,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        return _buildOrderCard(filteredOrders[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Pesanan Saya'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelColor: _isDark
              ? const Color(0xFFA8C9A5)
              : AppColors.primaryGreen,
          unselectedLabelColor: _isDark
              ? const Color(0xFFBEC8BE)
              : Colors.black87,
          labelStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
          indicatorColor: AppColors.primaryGreen,
          indicatorWeight: 3,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: _statuses.map((status) {
            return Tab(text: status);
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _statuses.map((status) {
          return _buildOrderList(status);
        }).toList(),
      ),
    );
  }
}