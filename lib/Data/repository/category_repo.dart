import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pcnc_ecommerce/domain/entities/categorymodel.dart';

class CategoryRepository {
  Future<List<Category>> fetchCategories() async {
    try {
      final response = await http
          .get(Uri.parse('https://api.escuelajs.co/api/v1/categories'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Failed to load categories');
    }
  }
}
