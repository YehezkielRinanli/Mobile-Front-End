import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final Color primaryGreen = const Color(0xFF2A5940);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCustomAppBar(),
              _buildSearchBar(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: HeroBannerCard(),
              ),
              const SizedBox(height: 16),

              // Kategori Section
              SectionHeader(
                title: "Kategori",
                onTapSeeAll: () {
                  // TODO: Navigasi ke halaman semua kategori
                },
              ),
              _buildCategories(),
              const SizedBox(height: 8),

              // Rekomendasi Section
              SectionHeader(
                title: "Rekomendasi Untukmu",
                onTapSeeAll: () {
                  // TODO: Navigasi ke halaman semua produk
                },
              ),
              _buildRecommendations(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: primaryGreen,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  // --- Ekstraksi Method untuk Kerapian build() ---

  Widget _buildCustomAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Row(
        children: [
          Icon(Icons.eco, color: primaryGreen, size: 28),
          const SizedBox(width: 8),
          Text(
            "CraftOrigin",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: primaryGreen,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              // TODO: Aksi buka notifikasi
            },
            icon: const Icon(Icons.notifications_none, size: 28),
            color: Colors.black87,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Cari produk, perajin, atau daerah...",
          hintStyle: TextStyle(color: Colors.grey.shade500),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    final List<Map<String, dynamic>> categories = [
      {'icon': Icons.shopping_bag, 'label': 'Tas & Aksesori'},
      {'icon': Icons.chair, 'label': 'Dekorasi'},
      {'icon': Icons.grid_on, 'label': 'Anyaman'},
      {'icon': Icons.spa, 'label': 'Keramik'},
      {'icon': Icons.kitchen, 'label': 'Alat Rumah'},
      {'icon': Icons.checkroom, 'label': 'Pakaian'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 8,
          childAspectRatio: 0.9,
        ),
        itemBuilder: (context, index) {
          final cat = categories[index];

          return CategoryItem(
            icon: cat['icon'] as IconData,
            label: cat['label'] as String,
          );
        },
      ),
    );
  }

  Widget _buildRecommendations() {
    return SizedBox(
      height: 230, // Tinggi yang cukup untuk gambar dan teks
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        scrollDirection: Axis.horizontal,
        itemCount: 4, // Contoh 4 produk
        itemBuilder: (context, index) {
          return const ProductCard(
            productName: "Tas Anyaman Rotan Khas",
            price: "Rp 150.000",
            artisanName: "Ibu Siti, Bali",
          );
        },
      ),
    );
  }
}

// ============================================================================
// WIDGET REUSABLE (MODULAR COMPONENTS)
// ============================================================================

class HeroBannerCard extends StatelessWidget {
  const HeroBannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade300, // Placeholder warna abu-abu
        image: DecorationImage(
          image: AssetImage('assets/images/banner_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Overlay gradient agar teks lebih terbaca jika pakai gambar
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Produk Lokal\nRamah Lingkungan",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Aksi belanja
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2A5940), // Warna utama
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                  ),
                  child: const Text("Belanja Sekarang \u2192"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onTapSeeAll;

  const SectionHeader({
    super.key,
    required this.title,
    required this.onTapSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          GestureDetector(
            onTap: onTapSeeAll,
            child: const Text(
              "Lihat Semua >",
              style: TextStyle(
                color: Color(0xFF2A5940),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF1EFE9),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFF2A5940), size: 34),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final String productName;
  final String price;
  final String artisanName;

  const ProductCard({
    super.key,
    required this.productName,
    required this.price,
    required this.artisanName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar Produk & Label Eco-Friendly
          Stack(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300, // Placeholder gambar
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  // image: DecorationImage(image: AssetImage('...'), fit: BoxFit.cover),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade600,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.energy_savings_leaf,
                        color: Colors.white,
                        size: 12,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "Eco-Friendly",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Informasi Produk
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  artisanName,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2A5940),
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
