import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final Dio _dio = Dio();
  static const String _tokenKey = 'user_token';
  static const String _baseUrl =
      'https://jsonplaceholder.typicode.com'; // Mock API

  // Login method
  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    try {
      // Mock login API call
      final response = await _dio.post(
        '$_baseUrl/posts', // Using posts endpoint as mock login
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 201) {
        // Mock successful response with token
        final token = response.data['token'];
        await _saveToken(token);

        return {
          'success': true,
          'token': token,
          'message': 'Login successful',
        };
      } else {
        return {
          'success': false,
          'message': 'Login failed',
        };
      }
    } on DioException catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.message}',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Unexpected error: $e',
      };
    }
  }

  // Save token to SharedPreferences
  static Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Get token from SharedPreferences
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Logout - remove token
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // Get user data (mock)
  static Future<Map<String, dynamic>> getUserData() async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('No token found');
      }

      // Mock API call with token
      final response = await _dio.get(
        '$_baseUrl/users/1',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return {
        'success': true,
        'user': response.data,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to get user data: $e',
      };
    }
  }
}
