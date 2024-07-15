import 'package:http/http.dart' as http;
import 'dart:convert';

class SRemoteDataSource {
  final String baseUrl = 'https://api.escuelajs.co/api/v1/users/';

  Future<Map<String, dynamic>> signup(String name, String email, String password, String avatar) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'avatar': avatar,
      }),
    );

    print('Request Body: ${jsonEncode({
      'name': name,
      'email': email,
      'password': password,
      'avatar': avatar,
    })}'); // Logging request body

    print('Response Status Code: ${response.statusCode}'); // Logging status code
    print('Response Body: ${response.body}'); // Logging response body

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create user: ${response.body}'); // Enhanced error message
    }
  }
}
