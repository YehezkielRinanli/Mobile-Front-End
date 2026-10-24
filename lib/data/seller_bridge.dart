import '../models/product.dart';
import '../models/seller.dart';
import '../utils/formatters.dart';
import 'product_data.dart';


const Map<String, String> _teamSellerIds = {
  'siti_aminah': 's1', 
  'wayan_sudarta': 's2', 
  'maria_lado': 's3', 
  'rudi_hartono': 's4', 
  'andi_baso': 's4', 
};


String _groupKey(String sellerId) => _teamSellerIds[sellerId] ?? sellerId;

Seller? registeredSellerFor(String sellerId) {
  final teamId = _teamSellerIds[sellerId];
  if (teamId == null) return null;
  for (final seller in dummySellers) {
    if (seller.id == teamId) return seller;
  }
  return null;
}

List<SellerProduct> catalogOfSeller(String sellerId) {
  final key = _groupKey(sellerId);
  return sampleProducts
      .where((p) => _groupKey(p.sellerId) == key)
      .map(
        (p) => SellerProduct(
          id: p.id,
          name: p.name,
          category: p.category.label,
          price: formatRupiah(p.price),
          image: p.image,
          location: p.location,
          description: p.description,
        ),
      )
      .toList();
}

Seller sellerForProduct(Product product) {
  final catalog = catalogOfSeller(product.sellerId);
  final team = registeredSellerFor(product.sellerId);

  if (team != null) {
    return Seller(
      id: team.id,
      name: team.name,
      shopName: team.shopName,
      photo: team.photo,
      location: team.location,
      bio: team.bio,
      rating: team.rating,
      products: catalog.isEmpty ? team.products : catalog,
    );
  }

  final mine = sampleProducts
      .where((p) => _groupKey(p.sellerId) == _groupKey(product.sellerId))
      .toList();
  final averageRating = mine.isEmpty
      ? product.rating
      : mine.fold<double>(0, (sum, p) => sum + p.rating) / mine.length;

  return Seller(
    id: product.sellerId,
    name: product.sellerName,
    shopName: 'Karya ${product.sellerName}',
    photo: '',
    location: product.location,
    bio:
        '${product.sellerName} adalah ${product.sellerRole.toLowerCase()} '
        'dari ${product.location}. Setiap karyanya dibuat dengan tangan '
        'dan bahan alami.',
    rating: double.parse(averageRating.toStringAsFixed(1)),
    products: catalog,
  );
}
