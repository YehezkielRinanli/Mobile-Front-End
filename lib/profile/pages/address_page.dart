import 'package:flutter/material.dart';

import '../models/user_profile.dart';
import '../widgets/info_row.dart';
import '../widgets/profile_colors.dart';
import '../widgets/section_card.dart';
import '../widgets/sub_page.dart';
import 'add_address_page.dart';

/// Menampilkan semua alamat pengiriman yang tersimpan pada data contoh.
class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  Future<void> _addAddress() async {
    final saved = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const AddAddressPage()),
    );

    if (saved == true && mounted) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Alamat baru berhasil ditambahkan.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = PColors.of(context);
    final addresses = ProfileData.addresses;

    return SubPage(
      title: 'Alamat Saya',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < addresses.length; i++) ...[
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    addresses[i].label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: colors.heading,
                    ),
                  ),
                  Divider(color: colors.border),
                  InfoRow(
                    icon: Icons.person_outline,
                    label: 'Penerima',
                    value: addresses[i].recipient,
                  ),
                  InfoRow(
                    icon: Icons.phone_outlined,
                    label: 'Telepon',
                    value: addresses[i].phone,
                  ),
                  InfoRow(
                    icon: Icons.home_outlined,
                    label: 'Alamat',
                    value: addresses[i].detail,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
          const SizedBox(height: 4),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _addAddress,
              icon: const Icon(Icons.add_location_alt_outlined),
              label: const Text('Tambah Alamat'),
            ),
          ),
        ],
      ),
    );
  }
}
