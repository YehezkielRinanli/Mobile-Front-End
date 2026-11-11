import 'package:flutter/material.dart';

import '../core/constants/app_spacing.dart';
import '../models/seller.dart';
import '../widgets/seller/seller_empty_state.dart';
import '../widgets/seller/seller_grid.dart';
import '../widgets/seller/seller_search_bar.dart';
import 'seller_profile_screen.dart';

class SellerCatalogScreen extends StatefulWidget {
  const SellerCatalogScreen({super.key});

  @override
  State<SellerCatalogScreen> createState() => _SellerCatalogScreenState();
}

class _SellerCatalogScreenState extends State<SellerCatalogScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Daftar perajin yang namanya cocok dengan teks pencarian
  List<Seller> get _filteredSellers {
    final keyword = _query.trim().toLowerCase();
    if (keyword.isEmpty) return dummySellers;

    return dummySellers
        .where((seller) => seller.name.toLowerCase().contains(keyword))
        .toList();
  }

  void _openProfile(Seller seller) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SellerProfileScreen(seller: seller),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final sellers = _filteredSellers;
    final isSearching = _query.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kenali Perajinnya'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: SellerSearchBar(
              controller: _searchController,
              onChanged: (value) => setState(() => _query = value),
              onClear: () {
                _searchController.clear();
                setState(() => _query = '');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Text(
              isSearching
                  ? '${sellers.length} perajin ditemukan'
                  : '${sellers.length} perajin',
              style: textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: sellers.isEmpty
                ? SellerEmptyState(query: _query.trim())
                : SellerGrid(sellers: sellers, onSellerTap: _openProfile),
          ),
        ],
      ),
    );
  }
}