import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final List<Map<String, dynamic>> addresses = [
    {
      'name': 'Choi Soobin',
      'phone': '081234567890',
      'label': 'Rumah',
      'address': 'Jl. Contoh No. 10, Medan, Sumatera Utara',
      'isMain': true,
    },
  ];

  bool get isDark =>
      Theme.of(context).brightness == Brightness.dark;

  Color get headingColor => isDark
      ? const Color(0xFFF1EFE9)
      : AppColors.darkGreen;

  Color get secondaryColor =>
      isDark ? const Color(0xFFBEC8BE) : Colors.grey.shade700;

  Color get primaryColor => isDark
      ? const Color(0xFFA8C9A5)
      : AppColors.primaryGreen;

  Color get cardColor =>
      isDark ? Theme.of(context).cardColor : AppColors.card;

  Color get borderColor => isDark
      ? const Color(0xFF35463A)
      : AppColors.lightGreenBorder;

  Future<void> showAddressForm({int? index}) async {
    final Map<String, dynamic>? existingAddress =
        index == null ? null : Map<String, dynamic>.from(addresses[index]);

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (dialogContext) {
        return _AddressFormDialog(
          address: existingAddress,
          isDark: isDark,
          primaryColor: primaryColor,
          headingColor: headingColor,
          secondaryColor: secondaryColor,
          cardColor: cardColor,
        );
      },
    );

    if (!mounted || result == null) return;

    setState(() {
      if (index == null) {
        result['isMain'] = addresses.isEmpty;
        addresses.add(result);
      } else {
        result['isMain'] = addresses[index]['isMain'] == true;
        addresses[index] = result;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          index == null
              ? 'Alamat berhasil ditambahkan.'
              : 'Alamat berhasil diperbarui.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void deleteAddress(int index) {
    if (addresses.length == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Minimal harus ada satu alamat.'),
        ),
      );
      return;
    }

    final bool wasMain = addresses[index]['isMain'] == true;

    setState(() {
      addresses.removeAt(index);

      if (wasMain) {
        addresses[0]['isMain'] = true;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Alamat berhasil dihapus.'),
      ),
    );
  }

  void setMainAddress(int index) {
    setState(() {
      for (int i = 0; i < addresses.length; i++) {
        addresses[i]['isMain'] = i == index;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Alamat utama berhasil diubah.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Alamat Saya',
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
      body: addresses.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_off_outlined,
                      size: 60,
                      color: secondaryColor,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Belum ada alamat',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: headingColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tambahkan alamat untuk memudahkan pengiriman.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: secondaryColor),
                    ),
                  ],
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Daftar Alamat',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: headingColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Kelola alamat tujuan pengirimanmu.',
                  style: TextStyle(
                    fontSize: 13,
                    color: secondaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                ...List.generate(addresses.length, (index) {
                  final item = addresses[index];
                  final isMain = item['isMain'] == true;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isMain ? primaryColor : borderColor,
                        width: isMain ? 1.5 : 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: primaryColor,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                item['label'] as String,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: headingColor,
                                ),
                              ),
                            ),
                            if (isMain)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? const Color(0xFF29382F)
                                      : AppColors.lightGreen,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Utama',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          item['name'] as String,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: headingColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['phone'] as String,
                          style: TextStyle(color: secondaryColor),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item['address'] as String,
                          style: TextStyle(
                            color: secondaryColor,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Divider(color: borderColor),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            TextButton.icon(
                              onPressed: () =>
                                  showAddressForm(index: index),
                              icon: const Icon(
                                Icons.edit_outlined,
                                size: 18,
                              ),
                              label: const Text('Edit'),
                              style: TextButton.styleFrom(
                                foregroundColor: primaryColor,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () => deleteAddress(index),
                              icon: const Icon(
                                Icons.delete_outline,
                                size: 18,
                              ),
                              label: const Text('Hapus'),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.redAccent,
                              ),
                            ),
                            if (!isMain)
                              TextButton(
                                onPressed: () => setMainAddress(index),
                                style: TextButton.styleFrom(
                                  foregroundColor: primaryColor,
                                ),
                                child: const Text('Jadikan Utama'),
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showAddressForm(),
        backgroundColor: primaryColor,
        foregroundColor: isDark ? AppColors.darkGreen : Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Alamat'),
      ),
    );
  }
}

// Form dibuat sebagai StatefulWidget tersendiri agar
// controller dikelola dan dibersihkan oleh widget pemiliknya.
class _AddressFormDialog extends StatefulWidget {
  final Map<String, dynamic>? address;
  final bool isDark;
  final Color primaryColor;
  final Color headingColor;
  final Color secondaryColor;
  final Color cardColor;

  const _AddressFormDialog({
    required this.address,
    required this.isDark,
    required this.primaryColor,
    required this.headingColor,
    required this.secondaryColor,
    required this.cardColor,
  });

  @override
  State<_AddressFormDialog> createState() =>
      _AddressFormDialogState();
}

class _AddressFormDialogState extends State<_AddressFormDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _labelController;
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();

    final address = widget.address;

    _nameController = TextEditingController(
      text: address?['name'] as String? ?? '',
    );
    _phoneController = TextEditingController(
      text: address?['phone'] as String? ?? '',
    );
    _labelController = TextEditingController(
      text: address?['label'] as String? ?? '',
    );
    _addressController = TextEditingController(
      text: address?['address'] as String? ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _labelController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: TextStyle(color: widget.headingColor),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: widget.secondaryColor),
        prefixIcon: Icon(
          icon,
          color: widget.primaryColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: widget.primaryColor),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$label wajib diisi';
        }

        if (label == 'Nomor telepon' &&
            value.trim().length < 8) {
          return 'Nomor telepon minimal 8 karakter';
        }

        return null;
      },
    );
  }

  void _saveAddress() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.of(context).pop(<String, dynamic>{
      'name': _nameController.text.trim(),
      'phone': _phoneController.text.trim(),
      'label': _labelController.text.trim(),
      'address': _addressController.text.trim(),
      'isMain': widget.address?['isMain'] == true,
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: widget.cardColor,
      title: Text(
        widget.address == null ? 'Tambah Alamat' : 'Edit Alamat',
        style: TextStyle(
          color: widget.headingColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(
                controller: _nameController,
                label: 'Nama penerima',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _phoneController,
                label: 'Nomor telepon',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _labelController,
                label: 'Label alamat (Rumah/Kantor)',
                icon: Icons.label_outline,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _addressController,
                label: 'Alamat lengkap',
                icon: Icons.location_on_outlined,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Batal',
            style: TextStyle(color: widget.secondaryColor),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.primaryColor,
            foregroundColor:
                widget.isDark ? AppColors.darkGreen : Colors.white,
          ),
          onPressed: _saveAddress,
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}