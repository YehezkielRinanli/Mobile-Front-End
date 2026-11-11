import 'package:flutter/material.dart';

import '../models/user_profile.dart';
import '../widgets/profile_colors.dart';
import '../widgets/section_card.dart';
import '../widgets/sub_page.dart';

/// Form untuk menambahkan alamat pengiriman baru.
class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController();
  final _recipientController = TextEditingController();
  final _phoneController = TextEditingController();
  final _detailController = TextEditingController();

  @override
  void dispose() {
    _labelController.dispose();
    _recipientController.dispose();
    _phoneController.dispose();
    _detailController.dispose();
    super.dispose();
  }

  void _saveAddress() {
    if (!_formKey.currentState!.validate()) return;

    ProfileData.addresses.add(
      ShippingAddress(
        label: _labelController.text.trim(),
        recipient: _recipientController.text.trim(),
        phone: _phoneController.text.trim(),
        detail: _detailController.text.trim(),
      ),
    );

    Navigator.pop(context, true);
  }

  InputDecoration _decoration(String label, PColors colors) {
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
      title: 'Tambah Alamat',
      child: SectionCard(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Informasi Alamat Baru',
                style: TextStyle(
                  color: colors.heading,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Masukkan informasi penerima dan alamat pengiriman.',
                style: TextStyle(color: colors.secondary, fontSize: 12),
              ),
              const SizedBox(height: 16),

              // [M11 - INPUT] TextFormField digunakan untuk menginput label alamat baru.
              TextFormField(
                controller: _labelController,
                textInputAction: TextInputAction.next,
                decoration: _decoration('Label alamat (Rumah/Kantor)', colors),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Label alamat wajib diisi.'
                    : null,
              ),
              const SizedBox(height: 12),

              // [M11 - INPUT] TextFormField digunakan untuk menginput nama penerima.
              TextFormField(
                controller: _recipientController,
                textInputAction: TextInputAction.next,
                decoration: _decoration('Nama penerima', colors),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Nama penerima wajib diisi.'
                    : null,
              ),
              const SizedBox(height: 12),

              // [M11 - INPUT] TextFormField digunakan untuk menginput nomor telepon penerima.
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                decoration: _decoration('Nomor telepon', colors),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Nomor telepon wajib diisi.'
                    : null,
              ),
              const SizedBox(height: 12),

              // [M11 - INPUT] TextFormField digunakan untuk menginput detail alamat baru.
              TextFormField(
                controller: _detailController,
                minLines: 3,
                maxLines: 4,
                decoration: _decoration('Alamat lengkap', colors),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Alamat lengkap wajib diisi.'
                    : null,
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _saveAddress,
                  icon: const Icon(Icons.add_location_alt_outlined),
                  label: const Text('Simpan Alamat'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
