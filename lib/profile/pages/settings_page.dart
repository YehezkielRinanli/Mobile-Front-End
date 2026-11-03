import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/theme_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _promoNotifications = true;
  bool _orderNotifications = true;
  bool _securityNotifications = true;

  bool get _isDark =>
      Theme.of(context).brightness == Brightness.dark;

  Color get _primaryColor => _isDark
      ? const Color(0xFFA8C9A5)
      : AppColors.primaryGreen;

  Color get _headingColor => _isDark
      ? const Color(0xFFF1EFE9)
      : AppColors.darkGreen;

  Color get _secondaryTextColor =>
      _isDark ? const Color(0xFFBEC8BE) : Colors.grey.shade700;

  Color get _dividerColor => _isDark
      ? const Color(0xFF35463A)
      : AppColors.cream;

  Color get _cardColor =>
      _isDark ? Theme.of(context).cardColor : AppColors.card;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: _isDark
            ? const Color(0xFF29382F)
            : AppColors.primaryGreen,
      ),
    );
  }

  // Dialog untuk mengganti tema aplikasi.
  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: ThemeController.themeMode,
          builder: (context, currentMode, child) {
            return AlertDialog(
              backgroundColor: _cardColor,
              title: Text(
                'Tema Aplikasi',
                style: TextStyle(color: _headingColor),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<ThemeMode>(
                    value: ThemeMode.light,
                    groupValue: currentMode,
                    activeColor: _primaryColor,
                    title: Text(
                      'Light Mode',
                      style: TextStyle(color: _headingColor),
                    ),
                    secondary: Icon(
                      Icons.light_mode_outlined,
                      color: _primaryColor,
                    ),
                    onChanged: (value) {
                      if (value == null) return;

                      ThemeController.themeMode.value = value;
                      Navigator.pop(dialogContext);
                    },
                  ),
                  RadioListTile<ThemeMode>(
                    value: ThemeMode.dark,
                    groupValue: currentMode,
                    activeColor: _primaryColor,
                    title: Text(
                      'Dark Mode',
                      style: TextStyle(color: _headingColor),
                    ),
                    secondary: Icon(
                      Icons.dark_mode_outlined,
                      color: _primaryColor,
                    ),
                    onChanged: (value) {
                      if (value == null) return;

                      ThemeController.themeMode.value = value;
                      Navigator.pop(dialogContext);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Dialog informasi untuk menu pengaturan.
  void _showInfoDialog(String title, String description) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: _cardColor,
          title: Text(
            title,
            style: TextStyle(color: _headingColor),
          ),
          content: Text(
            description,
            style: TextStyle(color: _secondaryTextColor),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                'Tutup',
                style: TextStyle(color: _primaryColor),
              ),
            ),
          ],
        );
      },
    );
  }

  // Konfirmasi pembersihan cache.
  void _confirmClearCache() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: _cardColor,
          title: Text(
            'Bersihkan Cache',
            style: TextStyle(color: _headingColor),
          ),
          content: Text(
            'Fitur pembersihan cache belum dihubungkan '
            'ke penyimpanan aplikasi. Lanjutkan simulasi?',
            style: TextStyle(color: _secondaryTextColor),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                'Batal',
                style: TextStyle(color: _primaryColor),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                foregroundColor:
                    _isDark ? AppColors.darkGreen : Colors.white,
              ),
              onPressed: () {
                Navigator.pop(dialogContext);
                _showMessage(
                  'Ini masih simulasi. Cache perangkat belum dihapus.',
                );
              },
              child: const Text('Mengerti'),
            ),
          ],
        );
      },
    );
  }

  // Konfirmasi keluar akun.
  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: _cardColor,
          title: Text(
            'Keluar Akun',
            style: TextStyle(color: _headingColor),
          ),
          content: Text(
            'Apakah kamu yakin ingin keluar dari akun CraftOrigin?',
            style: TextStyle(color: _secondaryTextColor),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                'Batal',
                style: TextStyle(color: _primaryColor),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.terracotta,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(dialogContext);
                _showMessage(
                  'Fitur logout belum terhubung dengan autentikasi.',
                );
              },
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }

  // Judul setiap bagian pengaturan.
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 4,
        top: 22,
        bottom: 10,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: _headingColor,
        ),
      ),
    );
  }

  // Kartu yang menampung beberapa menu pengaturan.
  Widget _settingCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isDark
              ? const Color(0xFF35463A)
              : Colors.transparent,
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  // Widget menu pengaturan.
  Widget _settingTile({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: _primaryColor,
      ),
      title: Text(
        title,
        style: TextStyle(color: _headingColor),
      ),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle,
              style: TextStyle(color: _secondaryTextColor),
            ),
      trailing: trailing ??
          Icon(
            Icons.chevron_right,
            color: _secondaryTextColor,
          ),
      onTap: onTap,
    );
  }

  // Garis pemisah antar-menu.
  Widget _divider() {
    return Divider(
      height: 1,
      indent: 56,
      endIndent: 16,
      color: _dividerColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
        children: [
          // PREFERENSI APLIKASI
          _sectionTitle('Preferensi Aplikasi'),
          _settingCard([
            SwitchListTile(
              secondary: Icon(
                Icons.notifications_outlined,
                color: _primaryColor,
              ),
              title: Text(
                'Notifikasi',
                style: TextStyle(color: _headingColor),
              ),
              subtitle: Text(
                'Aktifkan semua pemberitahuan',
                style: TextStyle(color: _secondaryTextColor),
              ),
              value: _notificationsEnabled,
              activeTrackColor: AppColors.lightGreenBorder,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;

                  if (!value) {
                    _promoNotifications = false;
                    _orderNotifications = false;
                    _securityNotifications = false;
                  }
                });
              },
            ),
            _divider(),
            SwitchListTile(
              secondary: Icon(
                Icons.local_offer_outlined,
                color: _primaryColor,
              ),
              title: Text(
                'Promo dan Diskon',
                style: TextStyle(color: _headingColor),
              ),
              subtitle: Text(
                'Informasi penawaran dan promo',
                style: TextStyle(color: _secondaryTextColor),
              ),
              value: _promoNotifications,
              activeTrackColor: AppColors.lightGreenBorder,
              onChanged: _notificationsEnabled
                  ? (value) {
                      setState(() {
                        _promoNotifications = value;
                      });
                    }
                  : null,
            ),
            _divider(),
            SwitchListTile(
              secondary: Icon(
                Icons.local_shipping_outlined,
                color: _primaryColor,
              ),
              title: Text(
                'Pembaruan Pesanan',
                style: TextStyle(color: _headingColor),
              ),
              subtitle: Text(
                'Status dan pengiriman pesanan',
                style: TextStyle(color: _secondaryTextColor),
              ),
              value: _orderNotifications,
              activeTrackColor: AppColors.lightGreenBorder,
              onChanged: _notificationsEnabled
                  ? (value) {
                      setState(() {
                        _orderNotifications = value;
                      });
                    }
                  : null,
            ),
            _divider(),
            SwitchListTile(
              secondary: Icon(
                Icons.security_outlined,
                color: _primaryColor,
              ),
              title: Text(
                'Notifikasi Keamanan',
                style: TextStyle(color: _headingColor),
              ),
              subtitle: Text(
                'Pemberitahuan aktivitas akun',
                style: TextStyle(color: _secondaryTextColor),
              ),
              value: _securityNotifications,
              activeTrackColor: AppColors.lightGreenBorder,
              onChanged: _notificationsEnabled
                  ? (value) {
                      setState(() {
                        _securityNotifications = value;
                      });
                    }
                  : null,
            ),
            _divider(),
            ValueListenableBuilder<ThemeMode>(
              valueListenable: ThemeController.themeMode,
              builder: (context, mode, child) {
                final themeLabel = mode == ThemeMode.dark
                    ? 'Dark Mode'
                    : 'Light Mode';

                return _settingTile(
                  icon: mode == ThemeMode.dark
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                  title: 'Tema Aplikasi',
                  subtitle: themeLabel,
                  onTap: _showThemeDialog,
                );
              },
            ),
          ]),

          // AKUN DAN KEAMANAN
          _sectionTitle('Akun dan Keamanan'),
          _settingCard([
            _settingTile(
              icon: Icons.person_outline,
              title: 'Informasi Akun',
              subtitle: 'Lihat dan kelola informasi akun',
              onTap: () => _showInfoDialog(
                'Informasi Akun',
                'Pengelolaan informasi akun belum terhubung '
                'dengan data pengguna.',
              ),
            ),
            _divider(),
            _settingTile(
              icon: Icons.lock_outline,
              title: 'Keamanan Akun',
              subtitle: 'Kata sandi dan keamanan akun',
              onTap: () => _showInfoDialog(
                'Keamanan Akun',
                'Pengaturan kata sandi dan keamanan '
                'memerlukan sistem autentikasi.',
              ),
            ),
            _divider(),
            _settingTile(
              icon: Icons.privacy_tip_outlined,
              title: 'Privasi',
              subtitle: 'Informasi dan preferensi privasi',
              onTap: () => _showInfoDialog(
                'Privasi',
                'Halaman ini dapat dikembangkan untuk '
                'mengatur preferensi data.',
              ),
            ),
          ]),

          // PENYIMPANAN
          _sectionTitle('Penyimpanan'),
          _settingCard([
            _settingTile(
              icon: Icons.cleaning_services_outlined,
              title: 'Bersihkan Cache',
              subtitle: 'Kelola data sementara aplikasi',
              onTap: _confirmClearCache,
            ),
          ]),

          // LAINNYA
          _sectionTitle('Lainnya'),
          _settingCard([
            _settingTile(
              icon: Icons.info_outline,
              title: 'Tentang CraftOrigin',
              subtitle: 'Informasi aplikasi',
              onTap: () => _showInfoDialog(
                'Tentang CraftOrigin',
                'CraftOrigin adalah marketplace yang '
                'mendukung perajin lokal dan produk ramah lingkungan.',
              ),
            ),
            _divider(),
            _settingTile(
              icon: Icons.logout,
              title: 'Keluar Akun',
              subtitle: 'Keluar dari akun saat ini',
              onTap: _confirmLogout,
              trailing: Icon(
                Icons.chevron_right,
                color: _isDark
                    ? const Color(0xFFCF8C69)
                    : AppColors.terracotta,
              ),
            ),
          ]),

          const SizedBox(height: 24),
          Center(
            child: Text(
              'CraftOrigin • Versi 1.0.0',
              style: TextStyle(
                fontSize: 12,
                color: _secondaryTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}