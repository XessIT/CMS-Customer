import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../utils/url_endpoints.dart';

class LoginRepo {
  static const FlutterSecureStorage _storage = FlutterSecureStorage(); // Static instance

  // Static method to store the token
  static Future<void> _storeToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  // Static method for user login
  static Future<Map<String, dynamic>> loginUser(String mobile, String password) async {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({
        'mobile': mobile,
        'password': password,
      }),
    );

    // Check if response body is empty
    if (response.body.isEmpty) {
      throw Exception('Empty response body');
    }

    // Decode JSON response safely
    try {
      final responseData = jsonDecode(response.body);

      if (responseData['status'] == 'success') {
        final token = responseData['token'];
        await _storeToken(token);
        return {'status': 'success', 'token': token};
      } else {
        return {'status': 'failure', 'message': responseData['message'] ?? 'Login failed'};
      }
    } catch (error) {
      throw Exception('Failed to parse JSON response: $error');
    }
  }

  // Static method to retrieve the stored token
  static Future<String?> getToken() async {
    return await _storage.read(key: 'access_token');
  }
}
