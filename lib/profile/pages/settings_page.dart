import 'package:flutter/material.dart';
import '../widgets/info_row.dart';
import '../widgets/profile_colors.dart';
import '../widgets/section_card.dart';
import '../widgets/sub_page.dart';
import '../widgets/toggle_tile.dart';
// ===== M09 (Navigation) - MULAI =====
import 'account_page.dart';
// ===== M09 - SELESAI =====

// StatefulWidget dipakai karena status toggle bisa berubah.
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

/// Pengaturan (halaman Pengaturan & Keamanan).
class _SettingsPageState extends State<SettingsPage> {
  static const List<Map<String, dynamic>> _toggles = [
    {
      'icon': Icons.notifications_outlined,
      'title': 'Notifikasi',
      'subtitle': 'Aktifkan semua pemberitahuan',
      'on': true,
    },
    {
      'icon': Icons.local_offer_outlined,
      'title': 'Promo dan Diskon',
      'subtitle': 'Informasi penawaran dan promo',
      'on': true,
    },
    {
      'icon': Icons.local_shipping_outlined,
      'title': 'Pembaruan Pesanan',
      'subtitle': 'Status dan pengiriman pesanan',
      'on': true,
    },
    {
      'icon': Icons.security_outlined,
      'title': 'Notifikasi Keamanan',
      'subtitle': 'Pemberitahuan aktivitas akun',
      'on': true,
    },
    {
      'icon': Icons.verified_user_outlined,
      'title': 'Verifikasi Dua Langkah',
      'subtitle': 'Lapisan keamanan tambahan saat masuk',
      'on': false,
    },
    {
      'icon': Icons.notifications_active_outlined,
      'title': 'Peringatan Login',
      'subtitle': 'Beri tahu saat ada login baru',
      'on': false,
    },
  ];

  // Status on/off tiap toggle, diambil dari nilai awal pada _toggles.
  late final List<bool> _values =
      _toggles.map((t) => t['on'] as bool).toList();

  @override
  Widget build(BuildContext context) {
    final c = PColors.of(context);

    return SubPage(
      title: 'Pengaturan',
      child: SectionCard(
        child: Column(
          children: [
            InfoRow(
              icon: Icons.palette_outlined,
              label: 'Tema Aplikasi',
              value: c.isDark ? 'Dark Mode' : 'Light Mode',
            ),
            for (int i = 0; i < _toggles.length; i++) ...[
              Divider(color: c.border),
              ToggleTile(
                icon: _toggles[i]['icon'] as IconData,
                title: _toggles[i]['title'] as String,
                subtitle: _toggles[i]['subtitle'] as String,
                value: _values[i],
                onChanged: (v) {
                  setState(() {
                    _values[i] = v;
                  });
                },
              ),
            ],
            Divider(color: c.border),
            // ===== M09 (Navigation & User Interaction) - MULAI =====
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AccountPage()),
                );
              },
              // ===== M09 - SELESAI =====
              child: const InfoRow(
                icon: Icons.person_outline,
                label: 'Lihat dan kelola informasi akun',
                value: 'Informasi Akun',
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
