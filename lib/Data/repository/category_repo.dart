import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pcnc_ecommerce/domain/entities/categorymodel.dart';

class CategoryRepository {
  Future<List<Category>> fetchCategories({int limit = 10}) async {
    try {
      // Create a Request object with a limit parameter
      var request = http.Request(
        'GET',
        Uri.parse('https://api.escuelajs.co/api/v1/categories?limit=$limit'),
      );

      // Print the request details
      print('Request Method for categories: ${request.method}');
      print('Request URL for categories: ${request.url}');
      print('Request Headers for categories: ${request.headers}');

      // Send the request
      final response = await request.send();

      // Convert the streamed response into a Response object
      final httpResponse = await http.Response.fromStream(response);

      if (httpResponse.statusCode == 200 || httpResponse.statusCode == 201) {
        List<dynamic> data = json.decode(httpResponse.body);
        print('Response Status Code for categories: ${httpResponse.statusCode}');

        // Print each category individually
        data.forEach((category) {
          print('Category: $category');
        });

        return data.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Failed to load categories');
    }
  }
}
