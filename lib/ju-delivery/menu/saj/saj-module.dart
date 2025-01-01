class RestaurantItem {
  final String name;
  final String price;
  final String imageUrl;

  RestaurantItem({
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory RestaurantItem.fromFirestore(Map<String, dynamic> data) {
    return RestaurantItem(
      name: data['name'] ?? 'Unknown',
      price: data['price'] ?? '0.0',
      imageUrl: data['logourl'] ?? '',
    );
  }
}

