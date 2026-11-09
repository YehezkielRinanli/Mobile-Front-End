
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final List<Map<String, dynamic>> wishlistItems = [
    {
      'name': 'Tas Anyaman Rotan',
      'price': 150000,
      'seller': 'Ibu Siti, Bali',
      'icon': Icons.shopping_bag_outlined,
    },
    {
      'name': 'Vas Keramik Handmade',
      'price': 85000,
      'seller': 'Bapak Made, Yogyakarta',
      'icon': Icons.local_florist_outlined,
    },
    {
      'name': 'Hiasan Dinding Anyaman',
      'price': 120000,
      'seller': 'Ibu Rina, Lombok',
      'icon': Icons.home_outlined,
    },
  ];

  String formatPrice(int price) {
    return 'Rp ${price.toString().replaceAllMapped(
          RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => '.',
        )}';
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final cardColor = isDark ? Theme.of(context).cardColor : AppColors.card;

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
          'Wishlist',
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
      body: wishlistItems.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 64,
                      color: secondaryColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Wishlist masih kosong',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: headingColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Produk yang kamu sukai akan muncul di sini.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  '${wishlistItems.length} produk tersimpan',
                  style: TextStyle(
                    fontSize: 14,
                    color: secondaryColor,
                  ),
                ),
                const SizedBox(height: 12),

                ...wishlistItems.map((item) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: borderColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 76,
                          height: 82,
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF29382F)
                                : AppColors.lightGreen,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            item['icon'] as IconData,
                            size: 34,
                            color: primaryColor,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'] as String,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: headingColor,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                item['seller'] as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: secondaryColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                formatPrice(item['price'] as int),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                        IconButton(
                          tooltip: 'Hapus dari wishlist',
                          onPressed: () {
                            setState(() {
                              wishlistItems.remove(item);
                            });

                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Produk dihapus dari wishlist',
                                  ),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                          },
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
    );
  }
}
