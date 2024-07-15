import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pcnc_ecommerce/domain/entities/productmodel.dart';

class ProductRepository {
  Future<List<Product>> fetchProducts({int limit = 10}) async {
    try {
      // Create a Request object with a limit parameter
      var request = http.Request(
        'GET',
        Uri.parse('https://api.escuelajs.co/api/v1/products?limit=$limit'),
      );

      // Print the request details
      print('Request URL for products: ${request.url}');
     

      // Send the request
      final response = await request.send();

      // Convert the streamed response into a Response object
      final httpResponse = await http.Response.fromStream(response);

      if (httpResponse.statusCode == 200 || httpResponse.statusCode == 201) {
        List<dynamic> data = json.decode(httpResponse.body);
        print('Response Status Code for products: ${httpResponse.statusCode}');

        // Print each product individually
        data.forEach((product) {
          print('Product: $product');
        });

        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products');
    }
  }
}
