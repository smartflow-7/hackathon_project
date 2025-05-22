import 'dart:convert';

import 'api_service.dart';

class AuthService {
  // Sign up method
  static Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String name,
    // Add other required fields as needed
  }) async {
    try {
      final response = await ApiService.postRequest('auth/signup', {
        'email': email,
        'password': password,
        'name': name,
        // Include other fields as needed
      });

      if (response.statusCode == 201) {
        // Successful signup
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'message': 'Signup successful',
          'data': responseData,
        };
      } else {
        // Handle errors
        final errorData = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Signup failed',
          'error': errorData,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred: $e',
      };
    }
  }

  // Login method
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await ApiService.postRequest('auth/login', {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        // Successful login
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'message': 'Login successful',
          'data': responseData,
          'token': responseData['token'], // Assuming your API returns a token
        };
      } else {
        // Handle errors
        final errorData = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Login failed',
          'error': errorData,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred: $e',
      };
    }
  }

  // Optional: Logout method
  static Future<void> logout() async {
    // Clear local storage or tokens
    // This might not need an API call depending on your auth implementation
  }
}
