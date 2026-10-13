// ============================================================================
// ATURAN GAMBAR (otomatis, tidak perlu mengetik alamat gambar)
//
// Alamat gambar dibuat dari id. Cukup taruh file di folder assets/images/
// dengan nama:
//
//   foto perajin : seller_<id>     contoh: seller_siti_aminah.jpg
//   foto produk  : product_<id>    contoh: product_lampu_gantung_rotan.jpg
//
// Format .jpg / .jpeg / .png / .webp semuanya dikenali.
// Kalau filenya belum ada, tampil kotak abu-abu (tidak error).
// ============================================================================

/// Produk singkat yang tampil di katalog halaman profil perajin.
/// Nanti bisa diganti dengan model Product milik tim produk
/// kalau formatnya sudah disepakati.
///
/// CATATAN: field rating, reviewCount, dan location di bawah ini adalah
/// TEMPLATE sementara. Sesuaikan nama dan tipenya begitu tim sudah
/// sepakat soal data produk. Kartu produknya (ProductGridCard) menerima
/// data biasa, jadi cukup ubah model ini dan data contoh di bawah.
class SellerProduct {
  final String id; // Dipakai juga sebagai nama file gambar
  final String name;
  final int price; // Dalam rupiah, contoh: 350000
  final double rating; // Contoh: 4.8
  final int reviewCount; // Contoh: 120
  final String location; // Daerah asal produk, contoh: 'Sumatera Utara'
  final bool isEcoFriendly; // Belum ditampilkan di kartu katalog

  const SellerProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.location,
    this.isEcoFriendly = true,
  });

  /// Alamat gambar (tanpa ekstensi), dicari otomatis oleh AppImage.
  String get image => 'assets/images/product_$id';
}

class Seller {
  final String id; // Dipakai juga sebagai nama file foto
  final String name;
  final String shopName;
  final String phone; // Untuk ditampilkan, contoh: +62 812-3456-7890
  final String email; // Contoh: sitiaminah@gmail.com
  final double rating;
  final int reviewCount;
  final bool isTrusted;
  final String story;
  final List<SellerProduct> products;

  const Seller({
    required this.id,
    required this.name,
    required this.shopName,
    required this.phone,
    required this.email,
    required this.rating,
    required this.reviewCount,
    required this.story,
    required this.products,
    this.isTrusted = false,
  });

  /// Alamat foto perajin (tanpa ekstensi), dicari otomatis oleh AppImage.
  String get photo => 'assets/images/seller_$id';
}

// ============================================================================
// DATA CONTOH (sementara, sebelum ada backend / data asli)
// Untuk menambah penjual: salin satu blok Seller(...), ganti isinya,
// lalu masukkan ke list dummySellers di bawah.
// ============================================================================

const Seller dummySeller = Seller(
  id: 'siti_aminah',
  name: 'Siti Aminah',
  shopName: 'Rumah Rotan',
  phone: '+62 812-3456-7890',
  email: 'sitiaminah@gmail.com',
  rating: 4.9,
  reviewCount: 1200,
  isTrusted: true,
  story:
      'Siti Aminah telah menjadi perajin anyaman rotan selama lebih dari 20 '
      'tahun. Setiap karyanya mencerminkan keuletan dan cinta terhadap alam. '
      'Beliau berdedikasi untuk melestarikan budaya anyaman Indonesia, dan '
      'mendukung kesejahteraan masyarakat.',
  products: [
    SellerProduct(
      id: 'keranjang_buah_rotan',
      name: 'Keranjang Buah Rotan',
      price: 350000,
      rating: 4.8,
      reviewCount: 120,
      location: 'Sumatera Utara',
    ),
    SellerProduct(
      id: 'piring_anyaman_rotan',
      name: 'Piring Anyaman Rotan',
      price: 120000,
      rating: 4.7,
      reviewCount: 98,
      location: 'Sumatera Utara',
    ),
    SellerProduct(
      id: 'lampu_gantung_rotan',
      name: 'Lampu Gantung Rotan',
      price: 530000,
      rating: 4.9,
      reviewCount: 56,
      location: 'Sumatera Utara',
    ),
    SellerProduct(
      id: 'nampan_baki_rotan',
      name: 'Nampan Baki Rotan',
      price: 210000,
      rating: 4.6,
      reviewCount: 73,
      location: 'Sumatera Utara',
    ),
  ],
);

// Penjual kedua, hanya untuk membuktikan satu halaman bisa menampilkan
// banyak penjual dengan isi berbeda.
const Seller dummySeller2 = Seller(
  id: 'wayan_sudarta',
  name: 'Wayan Sudarta',
  shopName: 'Gerabah Tirta',
  phone: '+62 813-9876-5432',
  email: 'wayansudarta@gmail.com',
  rating: 4.7,
  reviewCount: 860,
  isTrusted: true,
  story:
      'Wayan Sudarta membuat gerabah dari tanah liat lokal sejak masih '
      'remaja. Setiap pembakaran dilakukan secara tradisional, sehingga '
      'hasilnya kuat, unik, dan ramah lingkungan.',
  products: [
    SellerProduct(
      id: 'keramik_lokal',
      name: 'Keramik Lokal',
      price: 120000,
      rating: 4.9,
      reviewCount: 56,
      location: 'Bali',
    ),
    SellerProduct(
      id: 'vas_tanah_liat',
      name: 'Vas Tanah Liat',
      price: 95000,
      rating: 4.5,
      reviewCount: 41,
      location: 'Bali',
    ),
  ],
);

/// Semua penjual contoh. Nanti diganti dengan data asli dari backend/database.
const List<Seller> dummySellers = [dummySeller, dummySeller2];

/// Cari penjual berdasarkan id. Berguna untuk halaman produk yang
/// hanya menyimpan sellerId.
Seller? findSellerById(String id) {
  for (final seller in dummySellers) {
    if (seller.id == id) return seller;
  }
  return null;
}
