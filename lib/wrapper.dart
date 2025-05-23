import 'package:flutter/material.dart';
import 'package:hackathon_project/Auth/Authenticate.dart';
import 'package:hackathon_project/screens/main_screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  static const route = '/wrapper';
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool _isLoading = true;
  bool _isAuthenticated = false;
  static const String _tokenKey = 'user_token';

  @override
  void initState() {
    super.initState();
    _checkAuthenticationStatus();
  }

  // Check if user has a valid token stored
  Future<void> _checkAuthenticationStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(_tokenKey);

      // Check if token exists and is not empty
      final hasValidToken = token != null && token.isNotEmpty;

      if (mounted) {
        setState(() {
          _isAuthenticated = hasValidToken;
          _isLoading = false;
        });
      }
    } catch (e) {
      // Handle any errors in checking token
      if (mounted) {
        setState(() {
          _isAuthenticated = false;
          _isLoading = false;
        });
      }
    }
  }

  // Method to refresh authentication status (can be called from child widgets)
  Future<void> refreshAuthStatus() async {
    setState(() {
      _isLoading = true;
    });
    await _checkAuthenticationStatus();
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator while checking token
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                'Checking authentication...',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    // Navigate based on authentication status
    if (_isAuthenticated) {
      return const Home();
    } else {
      return const Authenticate();
    }
  }
}

// Optional: Helper class for token management (can be used across the app)
class TokenManager {
  static const String _tokenKey = 'user_token';

  // Save token to SharedPreferences
  static Future<bool> saveToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(_tokenKey, token);
    } catch (e) {
      return false;
    }
  }

  // Get token from SharedPreferences
  static Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_tokenKey);
    } catch (e) {
      return null;
    }
  }

  // Check if user is authenticated
  static Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Remove token (logout)
  static Future<bool> removeToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_tokenKey);
    } catch (e) {
      return false;
    }
  }

  // Clear all stored data
  static Future<bool> clearAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.clear();
    } catch (e) {
      return false;
    }
  }
}
