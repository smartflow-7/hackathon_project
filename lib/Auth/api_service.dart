import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hackathon_project/models/user.dart';

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
      final storedToken = await _secureStorage.read(key: _tokenKey);

      if (storedToken != null) {
        _token = storedToken;
        _isAuthenticated = true;
        // Note: You might want to validate the token with the backend
        // and fetch fresh user data here
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
    _setLoading(true);
    try {
      final response = await _authService.signUp(
        email: email,
        password: password,
        name: name,
      );
      await _handleAuthSuccess(response);
      debugPrint('Signed up successfully');
      debugPrint('auth token: $token');
    } catch (e) {
      _setLoading(false);
      debugPrint('Sign up error: $e');
      rethrow;
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    try {
      final response = await _authService.signIn(
        email: email,
        password: password,
      );
      await _handleAuthSuccess(response);
      debugPrint('Signed in successfully');
    } catch (e) {
      _setLoading(false);
      debugPrint('Sign in error: $e');
      rethrow; // Re-enable rethrow to handle errors properly in UI
    }
  }

  Future<void> signOut() async {
    _setLoading(true);
    try {
      await _secureStorage.delete(key: _tokenKey);
      _user = null;
      _token = null;
      _isAuthenticated = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Error signing out: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _handleAuthSuccess(Map<String, dynamic> response) async {
    try {
      // Safely extract user data
      final userData = response['user'];
      final authToken = response['token'];

      if (authToken != null) {
        _token = authToken.toString();
        await _secureStorage.write(key: _tokenKey, value: _token!);
      }

      if (userData != null) {
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

  Future<String?> getStoredToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> clearAuthData() async {
    await _secureStorage.delete(key: _tokenKey);
    _user = null;
    _token = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}
