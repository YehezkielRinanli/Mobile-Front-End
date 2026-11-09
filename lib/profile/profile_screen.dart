import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_menu_item.dart';
import 'widgets/responsive_body.dart';
// ===== M09 (Navigation) - MULAI =====
import 'pages/account_page.dart';
import 'pages/orders_page.dart';
import 'pages/address_page.dart';
import 'pages/payment_page.dart';
import 'pages/help_page.dart';
import 'pages/settings_page.dart';
// ===== M09 - SELESAI =====

/// Data satu menu profil. Menu dibangun dari list lewat ListView
/// [M06], sehingga menambah/menghapus menu cukup mengubah list.
class _MenuEntry {
  final IconData icon;
  final String title;
  final Widget page;

  const _MenuEntry(this.icon, this.title, this.page);
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor = theme.scaffoldBackgroundColor;
    final cardColor = isDark ? theme.cardColor : AppColors.card;

    final headingColor =
        isDark ? const Color(0xFFF1EFE9) : AppColors.darkGreen;

    final borderColor =
        isDark ? const Color(0xFF35463A) : AppColors.lightGreenBorder;

    final primaryColor =
        isDark ? const Color(0xFFA8C9A5) : AppColors.primaryGreen;

    final entries = <_MenuEntry>[
      _MenuEntry(Icons.person_outline, 'Informasi Akun',
          const AccountPage()),
      _MenuEntry(Icons.shopping_bag_outlined, 'Pesanan Saya',
          const OrdersPage()),
      _MenuEntry(Icons.location_on_outlined, 'Alamat Saya',
          const AddressPage()),
      _MenuEntry(Icons.payment_outlined, 'Metode Pembayaran',
          const PaymentPage()),
      _MenuEntry(Icons.help_outline, 'Pusat Bantuan',
          const HelpPage()),
      _MenuEntry(Icons.settings_outlined, 'Pengaturan',
          const SettingsPage()),
    ];

    // ---- Bagian-bagian layar (dipakai ulang oleh layout sempit & lebar)
    final headerCard = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: ProfileHeader(
        // ===== M09 (Navigation) - MULAI =====
        onProfileTap: () => _openPage(context, const AccountPage()),
        onSettingsTap: () => _openPage(context, const SettingsPage()),
        // ===== M09 - SELESAI =====
      ),
    );

    final menuSection = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Akun Saya',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: headingColor,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor),
          ),
          // [M06] ListView.separated; shrinkWrap karena berada di dalam
          // SingleChildScrollView.
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: entries.length,
            separatorBuilder: (_, __) => _buildDivider(borderColor),
            itemBuilder: (context, index) {
              final entry = entries[index];
              return ProfileMenuItem(
                icon: entry.icon,
                title: entry.title,
                // ===== M09 (Navigation) - MULAI =====
                onTap: () => _openPage(context, entry.page),
                // ===== M09 - SELESAI =====
              );
            },
          ),
        ),
      ],
    );

    final infoCard = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF263A2D) : AppColors.lightGreen,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.eco_outlined, size: 28, color: primaryColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
    );

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
      // [M07] Constraint: lebar konten dibatasi (ResponsiveBody).
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ResponsiveBody(
          maxWidth: 720,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerCard,
              const SizedBox(height: 24),
              menuSection,
              const SizedBox(height: 24),
              infoCard,
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ===== M09 (Navigation & User Interaction) - MULAI =====
  // Pindah ke halaman lain.
  Future<void> _openPage(BuildContext context, Widget page) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );

    // Perbarui header setelah pengguna kembali dari halaman edit profil.
    if (mounted) setState(() {});
  }
  // ===== M09 - SELESAI =====

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
