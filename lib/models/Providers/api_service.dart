import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hackathon_project/models/user.dart';
import 'dart:convert';

class AuthService {
  final Dio _dio = Dio();
  static const String baseUrl = 'https://stockup-auz8.onrender.com';

  AuthService() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers['Content-Type'] = 'application/json';

    // Add response interceptor to handle type conversion
    _dio.interceptors.add(InterceptorsWrapper(
      onResponse: (response, handler) {
        // Convert dynamic response to proper types
        if (response.data is Map) {
          response.data = Map<String, dynamic>.from(response.data);
        }
        handler.next(response);
      },
      onError: (error, handler) {
        debugPrint('API Error: ${error.response?.data}');
        handler.next(error);
      },
    ));
  }

  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await _dio.post('/stockUp/user/signup', data: {
        'email': email,
        'password': password,
        'name': name,
      });

      // Safely convert the response data
      return _convertToStringMap(response.data);
    } on DioException catch (e) {
      throw 'Sign up failed: ${_getErrorMessage(e)}';
    } catch (e) {
      throw 'Sign up failed: ${e.toString()}';
    }
  }

  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post('/stockUp/user/signin', data: {
        'email': email,
        'password': password,
      });

      // Safely convert the response data
      return _convertToStringMap(response.data);
    } on DioException catch (e) {
      throw 'Sign in failed: ${_getErrorMessage(e)}';
    } catch (e) {
      throw 'Sign in failed: ${e.toString()}';
    }
  }

  // Method to fetch fresh user data from server
  Future<Map<String, dynamic>> getUserProfile(String token) async {
    try {
      final response = await _dio.get(
        '/stockUp/user/profile', // Adjust endpoint as needed
        options: Options(
          headers: {
            'token': token,
          },
        ),
      );

      return _convertToStringMap(response.data);
    } on DioException catch (e) {
      throw 'Failed to fetch user profile: ${_getErrorMessage(e)}';
    } catch (e) {
      throw 'Failed to fetch user profile: ${e.toString()}';
    }
  }

  // Helper method to safely convert Map<dynamic, dynamic> to Map<String, dynamic>
  Map<String, dynamic> _convertToStringMap(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data;
    } else if (data is Map) {
      return Map<String, dynamic>.from(data);
    } else {
      throw Exception('Unexpected response format');
    }
  }

  // Helper method to extract error messages from DioException
  String _getErrorMessage(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout';
      case DioExceptionType.sendTimeout:
        return 'Send timeout';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout';
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?['message'] ?? 'Unknown error';
        return 'Server error ($statusCode): $message';
      case DioExceptionType.cancel:
        return 'Request cancelled';
      case DioExceptionType.connectionError:
        return 'Connection error';
      default:
        return error.message ?? 'Unknown error occurred';
    }
  }
}

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data'; // Added for storing user data

  User? _user;
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _token;

  User? get user => _user;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get token => _token;

  Future<void> initialize() async {
    _setLoading(true);
    try {
      // Refresh user data from server to get latest information
      await refreshUserData();
      final storedToken = await _secureStorage.read(key: _tokenKey);
      final storedUserData = await _secureStorage.read(key: _userKey);
      debugPrint('userid: $userId');

      if (storedToken != null) {
        _token = storedToken;
        _isAuthenticated = true;

        // Restore user data if available
        if (storedUserData != null) {
          try {
            final userJson = jsonDecode(storedUserData);
            final userId = userJson['_id']?.toString() ?? '';
            _user = User.fromJson(userJson, userId);
            debugPrint('User data restored: ${_user?.name}');
          } catch (e) {
            debugPrint('Error restoring user data: $e');
            // Clear corrupted user data
            await _secureStorage.delete(key: _userKey);
          }
        }
      }
    } catch (e) {
      debugPrint('Error initializing auth: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      _setLoading(true);
      try {
        final response = await _authService.signUp(
          email: email,
          password: password,
          name: name,
        );
        await _handleAuthSuccess(response);
        debugPrint('Signed up successfully');
        debugPrint('User: ${_user?.name} (${_user?.email})');
        debugPrint('Auth token: $token');
      } catch (e) {
        _setLoading(false);
        debugPrint('Sign up error: $e');
        rethrow;
      }
    } else {
      debugPrint('Empty text fields');
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      _setLoading(true);
      try {
        final response = await _authService.signIn(
          email: email,
          password: password,
        );
        await _handleAuthSuccess(response);

        // Refresh user data after successful login to ensure we have latest data
        await refreshUserData();

        debugPrint('Signed in successfully');
        debugPrint('User: ${_user?.name} (${_user?.email})');
      } catch (e) {
        _setLoading(false);
        debugPrint('Sign in error: $e');
        rethrow;
      }
    } else {
      debugPrint('Empty text fields');
    }
  }

  Future<void> signOut() async {
    _setLoading(true);
    try {
      // Clear both token and user data
      await _secureStorage.delete(key: _tokenKey);
      await _secureStorage.delete(key: _userKey);

      _user = null;
      _token = null;
      _isAuthenticated = false;
      notifyListeners();

      debugPrint('User signed out successfully');
    } catch (e) {
      debugPrint('Error signing out: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _handleAuthSuccess(Map<String, dynamic> response) async {
    try {
      // Safely extract user data and token
      final userData = response['user'];
      final authToken = response['token'];

      // Store token first
      if (authToken != null) {
        _token = authToken.toString();
        await _secureStorage.write(key: _tokenKey, value: _token!);
        debugPrint('Token stored successfully');
      }

      // Store user data
      if (userData != null) {
        await _storeUserData(userData);
      }

      _isAuthenticated = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error handling auth success: $e');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // Helper method to store user data
  Future<void> _storeUserData(dynamic userData) async {
    try {
      // Ensure userData is properly typed
      Map<String, dynamic> userMap;
      if (userData is Map<String, dynamic>) {
        userMap = userData;
      } else if (userData is Map) {
        userMap = Map<String, dynamic>.from(userData);
      } else {
        throw Exception('Invalid user data format');
      }

      // Create user object from response
      final userId = userMap['_id']?.toString() ?? '';
      _user = User.fromJson(userMap, userId);

      // Store user data persistently
      await _secureStorage.write(key: _userKey, value: jsonEncode(userMap));

      debugPrint('User data stored successfully: ${_user?.name}');
      debugPrint('User ID: ${_user?.id}');
      debugPrint('User Email: ${_user?.email}');
    } catch (e) {
      debugPrint('Error storing user data: $e');
      rethrow;
    }
  }

  // Method to refresh user data from server
  Future<void> refreshUserData() async {
    if (_token == null || !_isAuthenticated) {
      debugPrint('No token available for refreshing user data');
      return;
    }

    try {
      debugPrint('Refreshing user data from server...');
      final response = await _authService.getUserProfile(_token!);

      if (response['user'] != null) {
        await _storeUserData(response['user']);
        notifyListeners();
        debugPrint('User data refreshed successfully: ${_user?.name}');
      } else {
        debugPrint('No user data in refresh response');
      }
    } catch (e) {
      debugPrint('Error refreshing user data: $e');
      // Don't rethrow here as this is a background operation
      // The app should continue working with cached data
    }
  }

  // Method to force refresh user data (can be called manually)
  Future<void> forceRefreshUserData() async {
    if (_token == null || !_isAuthenticated) {
      throw Exception('User not authenticated');
    }

    _setLoading(true);
    try {
      await refreshUserData();
    } finally {
      _setLoading(false);
    }
  }

  // Method to update user data (useful for profile updates)
  Future<void> updateUserData(User updatedUser) async {
    try {
      _user = updatedUser;

      // Convert user back to JSON for storage
      final userJson = {
        '_id': updatedUser.id,
        'name': updatedUser.name,
        'email': updatedUser.email,
        // Add other user properties as needed
      };

      await _secureStorage.write(key: _userKey, value: jsonEncode(userJson));
      notifyListeners();

      debugPrint('User data updated successfully');
    } catch (e) {
      debugPrint('Error updating user data: $e');
      rethrow;
    }
  }

  // Method to get stored user data
  Future<Map<String, dynamic>?> getStoredUserData() async {
    try {
      final storedData = await _secureStorage.read(key: _userKey);
      if (storedData != null) {
        return jsonDecode(storedData);
      }
      return null;
    } catch (e) {
      debugPrint('Error getting stored user data: $e');
      return null;
    }
  }

  Future<String?> getStoredToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> clearAuthData() async {
    await _secureStorage.delete(key: _tokenKey);
    await _secureStorage.delete(key: _userKey);
    _user = null;
    _token = null;
    _isAuthenticated = false;
    notifyListeners();
    debugPrint('All auth data cleared');
  }

  // Getter methods for easy access to user properties
  String? get userName => _user?.name;
  String? get userEmail => _user?.email;
  String? get userId => _user?.id;
}
