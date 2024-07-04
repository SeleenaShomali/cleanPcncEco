// domain/entities/productmodel.dart
import 'package:pcnc_ecommerce/domain/entities/categorymodel.dart';

class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final Category category;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: Category.fromJson(json['category']),
      images: List<String>.from(json['images']),
    );
  }
}
