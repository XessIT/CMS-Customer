import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/url_endpoints.dart';

class RegisterRepo {
  static const FlutterSecureStorage _storage = FlutterSecureStorage(); // Static instance

  // Static method to store the token
  static Future<void> _storeToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  static Future<Map<String, dynamic>> registerUser(String firstName,
      String lastName, String address,
      String mobile, String password) async {
    try {
      final response = await http.post(
        Uri.parse(registerUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'first_name': firstName,
          'last_name': lastName,
          'address': address,
          'mobile': mobile,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success']) {
          final token = responseData['token'];
          await _storeToken(token);
          return {'status': 'success', 'token': token};
        } else {
          return {
            'status': 'failure',
            'message': responseData['error'] ?? 'Registration failed'
          };
        }
      } else {
        return {
          'status': 'failure',
          'message': 'Server error: ${response.statusCode}'
        };
      }
    } catch (error) {
      return {
        'status': 'failure',
        'error': error.toString()
      };
    }
  }

  // Method to get the token from storage
  static Future<String?> _getToken() async {
    return await _storage.read(key: 'access_token');
  }

  // Method to fetch user data
  static Future<Map<String, dynamic>> fetchUserData() async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.get(
      Uri.parse(registerUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    // Check if response body is empty
    if (response.body.isEmpty) {
      throw Exception('Empty response body');
    }

    // Decode JSON response safely
    try {
      final responseData = jsonDecode(response.body);

      if (responseData['success']) {
        return {'status': 'success', 'user': responseData['user']};
      } else {
        return {
          'status': 'failure',
          'message': responseData['error'] ?? 'Failed to fetch user data'
        };
      }
    } catch (error) {
      throw Exception('Failed to parse JSON response: $error');
    }
  }

}