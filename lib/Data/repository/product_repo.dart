// data/repository/product_repo.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pcnc_ecommerce/domain/entities/productmodel.dart';

class ProductRepository {
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('https://api.escuelajs.co/api/v1/products'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products');
    }
  }
}
