import 'package:flutter/material.dart';

import '../widgets/cart_item_widget.dart'; // Mengimpor widget yang baru dibuat
import '../widgets/order_success_dialog.dart'; // Mengimpor dialog sukses pesanan

const Color craftOriginGreen = Color(0xFF204E38);

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Materi 4: Scaffold sebagai dasar Material 3
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () {},
        ),
        // Materi 3: Text & Rich Controls
        title: const Text(
          'Keranjang Saya',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Hapus Semua',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
        ],
      ),

      // Materi 1: Basic UI Layout
      // SingleChildScrollView agar layar bisa di-scroll jika item banyak
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Daftar Produk menggunakan Custom Widget yang sudah kita buat (Materi 3)
            const CartItemWidget(
              title: 'Tas Rotan Anyaman',
              price: 'Rp 150.000',
              quantity: 1,
              imageUrl: 'dummy',
            ),
            const CartItemWidget(
              title: 'Keramik Lokal',
              price: 'Rp 120.000',
              quantity: 1,
              imageUrl: 'dummy',
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.black12),
            const SizedBox(height: 16),

            // 2. Ringkasan Belanja
            const Text(
              'Ringkasan Belanja',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildSummaryRow('Subtotal (2 produk)', 'Rp 270.000'),
            const SizedBox(height: 8),
            _buildSummaryRow('Ongkos Kirim', 'Rp 25.000'),
            const SizedBox(height: 8),
            const Divider(color: Colors.black12),
            const SizedBox(height: 8),
            _buildSummaryRow('Total', 'Rp 295.000', isTotal: true),
            const SizedBox(height: 24),

            // 3. Alamat Pengiriman (Materi 4: Basic Mobile UI dengan ListTile)
            const Text(
              'Alamat Pengiriman',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.location_on_outlined,
                color: craftOriginGreen,
              ),
              title: const Text('Jl. Melati No. 12, Kuningan'),
              subtitle: const Text('Jakarta Selatan, DKI Jakarta 12950'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            const SizedBox(height: 16),

            // 4. Metode Pembayaran
            const Text(
              'Metode Pembayaran',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.account_balance_wallet_outlined,
                color: craftOriginGreen,
              ),
              title: const Text('Transfer Bank (BCA)'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            const SizedBox(height: 32),

            // 5. Tombol Checkout (Materi 4: Material 3 Button)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      craftOriginGreen, // Warna hijau utama aplikasi
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const OrderSuccessDialog();
                    },
                  );
                },
                child: const Text(
                  'Checkout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Fungsi pembantu untuk membuat baris ringkasan belanja (Materi 1: Basic UI Layout)
  Widget _buildSummaryRow(String title, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.black : Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
