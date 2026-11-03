
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_menu_item.dart';
import 'pages/orders_page.dart';
import 'pages/wishlist_page.dart';
import 'pages/address_page.dart';
import 'pages/payment_methods_page.dart';
import 'pages/help_center_page.dart';
import 'pages/settings_page.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor = theme.scaffoldBackgroundColor;
    final cardColor =
        isDark ? theme.cardColor : AppColors.card;

    final headingColor = isDark
        ? const Color(0xFFF1EFE9)
        : AppColors.darkGreen;

    final borderColor = isDark
        ? const Color(0xFF35463A)
        : AppColors.lightGreenBorder;

    final primaryColor = isDark
        ? const Color(0xFFA8C9A5)
        : AppColors.primaryGreen;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Profil Saya',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: headingColor,
          ),
        ),
        backgroundColor: backgroundColor,
        foregroundColor: headingColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER PROFIL
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: borderColor,
                ),
              ),
              child: ProfileHeader(
                onSettingsTap: () {
                  _openPage(
                    context,
                    const SettingsPage(),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // JUDUL MENU
            Text(
              'Akun Saya',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: headingColor,
              ),
            ),

            const SizedBox(height: 12),

            // DAFTAR MENU PROFIL
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: borderColor,
                ),
              ),
              child: Column(
                children: [
                  ProfileMenuItem(
                    icon: Icons.shopping_bag_outlined,
                    title: 'Pesanan Saya',
                    onTap: () {
                      _openPage(
                        context,
                        const OrdersPage(),
                      );
                    },
                  ),
                  _buildDivider(borderColor),

                  ProfileMenuItem(
                    icon: Icons.favorite_border,
                    title: 'Wishlist',
                    onTap: () {
                      _openPage(
                        context,
                        const WishlistPage(),
                      );
                    },
                  ),
                  _buildDivider(borderColor),

                  ProfileMenuItem(
                    icon: Icons.location_on_outlined,
                    title: 'Alamat Saya',
                    onTap: () {
                      _openPage(
                        context,
                        const AddressPage(),
                      );
                    },
                  ),
                  _buildDivider(borderColor),

                  ProfileMenuItem(
                    icon: Icons.payment_outlined,
                    title: 'Metode Pembayaran',
                    onTap: () {
                      _openPage(
                        context,
                        const PaymentMethodsPage(),
                      );
                    },
                  ),
                  _buildDivider(borderColor),

                  ProfileMenuItem(
                    icon: Icons.help_outline,
                    title: 'Pusat Bantuan',
                    onTap: () {
                      _openPage(
                        context,
                        const HelpCenterPage(),
                      );
                    },
                  ),
                  _buildDivider(borderColor),

                  ProfileMenuItem(
                    icon: Icons.settings_outlined,
                    title: 'Pengaturan',
                    onTap: () {
                      _openPage(
                        context,
                        const SettingsPage(),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // INFORMASI KARYA LOKAL
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF263A2D)
                    : AppColors.lightGreen,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: borderColor,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.eco_outlined,
                      size: 28,
                      color: primaryColor,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dukung Karya Lokal',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: headingColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Setiap pembelian membantu '
                          'melestarikan kerajinan Indonesia.',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.4,
                            color: isDark
                                ? const Color(0xFFCAD9CD)
                                : AppColors.darkGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _openPage(
    BuildContext context,
    Widget page,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  Widget _buildDivider(Color color) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 56,
      endIndent: 16,
      color: color,
    );
  }
}
