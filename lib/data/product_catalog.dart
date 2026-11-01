import 'package:flutter/foundation.dart';

class ProductCatalog {
  ProductCatalog._();

  static final ValueNotifier<Set<String>> favoriteNames =
      ValueNotifier<Set<String>>(<String>{});

  static final List<Map<String, dynamic>> products = [
    {
      'name': 'Serene Diffuser',
      'category': 'Home',
      'brand': 'Botanica Home',
      'price': 65.00,
      'oldPrice': 85.00,
      'discount': '23% OFF',
      'rating': '4.6 (112)',
      'image':
          'https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?w=600',
    },
    {
      'name': 'Botanica Renewal Serum',
      'category': 'Beauty',
      'brand': 'Botanica Beauty',
      'price': 88.00,
      'oldPrice': 110.00,
      'discount': '20% OFF',
      'rating': '4.6 (76)',
      'image':
          'https://images.unsplash.com/photo-1601049541289-9b1b7bbbfe19?w=600',
    },
    {
      'name': 'Hand-Thrown Ceramic Pot',
      'category': 'Home',
      'brand': 'Botanica Home',
      'price': 75.00,
      'oldPrice': 95.00,
      'discount': '21% OFF',
      'rating': '4.5 (54)',
      'image':
          'https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?w=600',
    },
    {
      'name': 'Bamboo & Bristle Dry Brush',
      'category': 'Wellness',
      'brand': 'Botanica Wellness',
      'price': 35.00,
      'oldPrice': 45.00,
      'discount': '22% OFF',
      'rating': '4.7 (92)',
      'image':
          'https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?w=600',
    },
  ];

  static bool isFavorite(String name) => favoriteNames.value.contains(name);

  static void toggleFavorite(String name) {
    final updated = Set<String>.of(favoriteNames.value);
    if (!updated.add(name)) {
      updated.remove(name);
    }
    favoriteNames.value = updated;
  }
}
