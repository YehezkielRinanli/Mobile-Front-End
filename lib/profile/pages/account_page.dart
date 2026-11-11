import 'package:flutter/material.dart';

import '../models/user_profile.dart';
import '../widgets/info_row.dart';
import '../widgets/profile_colors.dart';
import '../widgets/section_card.dart';
import '../widgets/sub_page.dart';
import 'edit_account_page.dart';

/// Informasi akun dan pintasan menuju form pengeditan profil.
class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Future<void> _openEditPage() async {
    final saved = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const EditAccountPage()),
    );

    // Memuat ulang informasi setelah form edit berhasil menyimpan data.
    if (saved == true && mounted) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informasi akun berhasil diperbarui.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = PColors.of(context);
    final profile = ProfileData.profile;

    return SubPage(
      title: 'Informasi Akun',
      child: Column(
        children: [
          SectionCard(
            child: Column(
              children: [
                InfoRow(
                  icon: Icons.person_outline,
                  label: 'Username',
                  value: profile.username,
                ),
                Divider(color: colors.border),
                InfoRow(
                  icon: Icons.edit_note_outlined,
                  label: 'Bio',
                  value: profile.bio.isEmpty ? 'Belum diisi' : profile.bio,
                ),
                Divider(color: colors.border),
                InfoRow(
                  icon: Icons.wc_outlined,
                  label: 'Jenis Kelamin',
                  value: profile.gender.label,
                ),
                Divider(color: colors.border),
                InfoRow(
                  icon: Icons.cake_outlined,
                  label: 'Tanggal Lahir',
                  value: profile.birthDateText,
                ),
                Divider(color: colors.border),
                InfoRow(
                  icon: Icons.phone_outlined,
                  label: 'Nomor Telepon',
                  value: profile.phone,
                ),
                Divider(color: colors.border),
                InfoRow(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: profile.email,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _openEditPage,
              icon: const Icon(Icons.edit_outlined),
              label: const Text('Edit Informasi Akun'),
            ),
          ),
        ],
      ),
    );
  }
}
