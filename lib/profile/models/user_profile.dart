enum Gender { male, female, secret }

extension GenderLabel on Gender {
  String get label {
    switch (this) {
      case Gender.male:
        return 'Laki-laki';
      case Gender.female:
        return 'Perempuan';
      case Gender.secret:
        return 'Rahasia';
    }
  }
}

/// Data profil pengguna (kelas Dart biasa, [M01]).
class UserProfile {
  final String username;
  final String bio;
  final Gender gender;
  final int? birthDay;
  final int? birthMonth;
  final int? birthYear;
  final String phone;
  final String email;

  const UserProfile({
    required this.username,
    this.bio = '',
    this.gender = Gender.secret,
    this.birthDay,
    this.birthMonth,
    this.birthYear,
    required this.phone,
    required this.email,
  });

  bool get hasBirthDate =>
      birthDay != null && birthMonth != null && birthYear != null;

  String get birthDateText {
    if (!hasBirthDate) return 'Belum diisi';
    const bulan = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
    ];
    return '$birthDay ${bulan[birthMonth! - 1]} $birthYear';
  }
}

/// Data alamat pengiriman untuk halaman Profil.
class ShippingAddress {
  final String label;
  final String recipient;
  final String phone;
  final String detail;

  const ShippingAddress({
    required this.label,
    required this.recipient,
    required this.phone,
    required this.detail,
  });
}

/// Penyimpanan data contoh bersama untuk halaman-halaman Profile.
/// Data ini masih berada di memori aplikasi dan belum tersimpan ke database.
class ProfileData {
  static UserProfile profile = const UserProfile(
    username: 'Choi Soobin',
    phone: '081234567890',
    email: 'soobinny@gmail.com',
  );

  /// Foto profil terpilih (path asset); null = foto default.
  static String? avatar;

  /// Akun media sosial: nama platform -> username.
  static final Map<String, String> socials = {};

  /// Daftar alamat contoh. Pengguna dapat menambahkan alamat baru.
  static final List<ShippingAddress> addresses = [
    const ShippingAddress(
      label: 'Rumah',
      recipient: 'Choi Soobin',
      phone: '081234567890',
      detail: 'Jl. Contoh No. 10, Medan, Sumatera Utara',
    ),
  ];
}
