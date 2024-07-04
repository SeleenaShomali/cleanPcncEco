import 'dart:convert';
import 'package:http/http.dart' as http;

class SRemoteDataSource {
  final String signupUrl = 'https://api.escuelajs.co/api/v1/users/';

  Future<Map<String, dynamic>> signup(String name, String email, String password, {String? avatar}) async {
    try {
      final response = await http.post(
        Uri.parse(signupUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
          'avatar': avatar ?? '', // Optional field
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else if (response.statusCode == 400) {
        throw Exception('Bad request: ${response.body}');
      } else {
        throw Exception('Failed to signup: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to signup: $e');
    }
  }
}
