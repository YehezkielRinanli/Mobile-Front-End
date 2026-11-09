import 'package:flutter/material.dart';

import '../models/user_profile.dart';
import '../widgets/profile_colors.dart';
import '../widgets/section_card.dart';
import '../widgets/sub_page.dart';

/// Form untuk mengubah informasi dasar akun pengguna.
class EditAccountPage extends StatefulWidget {
  const EditAccountPage({super.key});

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  late final TextEditingController _bioController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    final profile = ProfileData.profile;
    _usernameController = TextEditingController(text: profile.username);
    _bioController = TextEditingController(text: profile.bio);
    _phoneController = TextEditingController(text: profile.phone);
    _emailController = TextEditingController(text: profile.email);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _bioController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (!_formKey.currentState!.validate()) return;

    final oldProfile = ProfileData.profile;
    ProfileData.profile = UserProfile(
      username: _usernameController.text.trim(),
      bio: _bioController.text.trim(),
      gender: oldProfile.gender,
      birthDay: oldProfile.birthDay,
      birthMonth: oldProfile.birthMonth,
      birthYear: oldProfile.birthYear,
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
    );

    Navigator.pop(context, true);
  }

  InputDecoration _inputDecoration(String label, PColors colors) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: colors.soft.withValues(alpha: colors.isDark ? 0.45 : 0.55),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.primary, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = PColors.of(context);

    return SubPage(
      title: 'Edit Informasi Akun',
      child: SectionCard(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Perbarui informasi pribadi',
                style: TextStyle(
                  color: colors.heading,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Pastikan informasi yang kamu masukkan sudah benar.',
                style: TextStyle(color: colors.secondary, fontSize: 12),
              ),
              const SizedBox(height: 18),

              // [M11 - INPUT] TextFormField hanya digunakan pada form edit akun.
              TextFormField(
                controller: _usernameController,
                textInputAction: TextInputAction.next,
                decoration: _inputDecoration('Nama pengguna', colors),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama pengguna wajib diisi.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // [M11 - INPUT] Kolom bio merupakan input saat mengedit data akun.
              TextFormField(
                controller: _bioController,
                minLines: 2,
                maxLines: 3,
                decoration: _inputDecoration('Bio', colors),
              ),
              const SizedBox(height: 12),

              // [M11 - INPUT] Kolom telepon hanya muncul pada form edit data.
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                decoration: _inputDecoration('Nomor telepon', colors),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nomor telepon wajib diisi.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // [M11 - INPUT] Kolom email digunakan untuk mengubah data akun.
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                decoration: _inputDecoration('Email', colors),
                validator: (value) {
                  final email = value?.trim() ?? '';
                  if (email.isEmpty || !email.contains('@')) {
                    return 'Masukkan alamat email yang valid.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),

              // Jenis kelamin tetap ditampilkan sebagai informasi dan belum diedit.
              Text(
                'Jenis Kelamin: ${ProfileData.profile.gender.label}',
                style: TextStyle(
                  color: colors.secondary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _saveProfile,
                  icon: const Icon(Icons.save_outlined),
                  label: const Text('Simpan Perubahan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
