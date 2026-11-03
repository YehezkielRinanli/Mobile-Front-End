
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() =>
      _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  final List<Map<String, dynamic>> paymentMethods = [
    {
      'name': 'Transfer Bank',
      'detail': 'Transfer melalui rekening bank',
      'icon': Icons.account_balance_outlined,
      'isMain': true,
    },
    {
      'name': 'E-Wallet',
      'detail': 'Pembayaran melalui dompet digital',
      'icon': Icons.account_balance_wallet_outlined,
      'isMain': false,
    },
    {
      'name': 'COD',
      'detail': 'Bayar saat pesanan diterima',
      'icon': Icons.local_shipping_outlined,
      'isMain': false,
    },
  ];

  bool get isDark =>
      Theme.of(context).brightness == Brightness.dark;

  Color get headingColor => isDark
      ? const Color(0xFFF1EFE9)
      : AppColors.darkGreen;

  Color get secondaryColor => isDark
      ? const Color(0xFFBEC8BE)
      : Colors.grey.shade700;

  Color get primaryColor => isDark
      ? const Color(0xFFA8C9A5)
      : AppColors.primaryGreen;

  Color get cardColor =>
      isDark ? Theme.of(context).cardColor : AppColors.card;

  Color get borderColor => isDark
      ? const Color(0xFF35463A)
      : AppColors.lightGreenBorder;

  void showAddPaymentDialog() {
    final availableMethods = [
      {
        'name': 'Transfer Bank',
        'detail': 'Transfer melalui rekening bank',
        'icon': Icons.account_balance_outlined,
      },
      {
        'name': 'E-Wallet',
        'detail': 'Pembayaran melalui dompet digital',
        'icon': Icons.account_balance_wallet_outlined,
      },
      {
        'name': 'COD',
        'detail': 'Bayar saat pesanan diterima',
        'icon': Icons.local_shipping_outlined,
      },
      {
        'name': 'Kartu Debit/Kredit',
        'detail': 'Pembayaran dengan kartu',
        'icon': Icons.credit_card_outlined,
      },
    ];

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: cardColor,
          title: Text(
            'Tambah Metode Pembayaran',
            style: TextStyle(
              color: headingColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: availableMethods.map((method) {
              final exists = paymentMethods.any(
                (item) => item['name'] == method['name'],
              );

              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  method['icon'] as IconData,
                  color: primaryColor,
                ),
                title: Text(
                  method['name'] as String,
                  style: TextStyle(color: headingColor),
                ),
                subtitle: Text(
                  method['detail'] as String,
                  style: TextStyle(color: secondaryColor),
                ),
                trailing: exists
                    ? Icon(
                        Icons.check_circle,
                        color: primaryColor,
                      )
                    : const Icon(Icons.add),
                onTap: exists
                    ? null
                    : () {
                        setState(() {
                          paymentMethods.add({
                            ...method,
                            'isMain': paymentMethods.isEmpty,
                          });
                        });
                        Navigator.pop(dialogContext);
                      },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                'Tutup',
                style: TextStyle(color: primaryColor),
              ),
            ),
          ],
        );
      },
    );
  }

  void setMainPayment(int index) {
    setState(() {
      for (int i = 0; i < paymentMethods.length; i++) {
        paymentMethods[i]['isMain'] = i == index;
      }
    });
  }

  void removePayment(int index) {
    final wasMain = paymentMethods[index]['isMain'] == true;

    setState(() {
      paymentMethods.removeAt(index);

      if (wasMain && paymentMethods.isNotEmpty) {
        paymentMethods[0]['isMain'] = true;
      }
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Metode pembayaran berhasil dihapus.'),
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
          'Metode Pembayaran',
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Pembayaran Saya',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: headingColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Pilih metode pembayaran yang ingin kamu gunakan.',
            style: TextStyle(
              fontSize: 13,
              color: secondaryColor,
            ),
          ),
          const SizedBox(height: 18),

          if (paymentMethods.isEmpty)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: borderColor),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.payment_outlined,
                    size: 48,
                    color: secondaryColor,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Belum ada metode pembayaran',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: headingColor,
                    ),
                  ),
                ],
              ),
            ),

          ...List.generate(paymentMethods.length, (index) {
            final method = paymentMethods[index];
            final isMain = method['isMain'] == true;

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
                children: [
                  Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF29382F)
                              : AppColors.lightGreen,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          method['icon'] as IconData,
                          color: primaryColor,
                          size: 27,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              method['name'] as String,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: headingColor,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              method['detail'] as String,
                              style: TextStyle(
                                fontSize: 12,
                                color: secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isMain)
                        Icon(
                          Icons.check_circle,
                          color: primaryColor,
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Divider(color: borderColor),
                  Row(
                    children: [
                      if (isMain)
                        Expanded(
                          child: Text(
                            'Metode utama',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        )
                      else
                        Expanded(
                          child: TextButton(
                            onPressed: () => setMainPayment(index),
                            style: TextButton.styleFrom(
                              foregroundColor: primaryColor,
                              padding: EdgeInsets.zero,
                              alignment: Alignment.centerLeft,
                            ),
                            child: const Text('Jadikan utama'),
                          ),
                        ),
                      IconButton(
                        tooltip: 'Hapus metode',
                        onPressed: () => removePayment(index),
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 4),

          OutlinedButton.icon(
            onPressed: showAddPaymentDialog,
            icon: const Icon(Icons.add),
            label: const Text('Tambah Metode Pembayaran'),
            style: OutlinedButton.styleFrom(
              foregroundColor: primaryColor,
              side: BorderSide(color: primaryColor),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF263A2D)
                  : AppColors.lightGreen,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: primaryColor,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Metode pembayaran di halaman ini merupakan '
                    'contoh tampilan. Belum ada transaksi atau '
                    'integrasi pembayaran yang sebenarnya.',
                    style: TextStyle(
                      color: headingColor,
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
