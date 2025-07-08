import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Model classes (unchanged)
class UserSummary {
  final int trades;
  final double balance;
  final String badge;

  UserSummary({
    required this.trades,
    required this.balance,
    required this.badge,
  });

  factory UserSummary.fromJson(Map<String, dynamic> json) {
    return UserSummary(
      trades: json['trades'] ?? 0,
      balance: (json['balance'] ?? 0.0).toDouble(),
      badge: json['badge'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trades': trades,
      'balance': balance,
      'badge': badge,
    };
  }
}

class AISuggestion {
  final bool success;
  final String suggestion;
  final UserSummary userSummary;

  AISuggestion({
    required this.success,
    required this.suggestion,
    required this.userSummary,
  });

  factory AISuggestion.fromJson(Map<String, dynamic> json) {
    return AISuggestion(
      success: json['success'] ?? false,
      suggestion: json['suggestion'] ?? '',
      userSummary: UserSummary.fromJson(json['userSummary'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'suggestion': suggestion,
      'userSummary': userSummary.toJson(),
    };
  }
}

// Provider class
class AISuggestionProvider with ChangeNotifier {
  static const String _baseUrl =
      'https://stockup-auz8.onrender.com/stockUp/suggestion';

  final Dio _dio = Dio();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  AISuggestion? _suggestion;
  bool _isLoading = false;
  String? _error;

  // Getters (unchanged)
  AISuggestion? get suggestion => _suggestion;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasData => _suggestion != null;

  // Fetch AI suggestion
  Future<void> fetchSuggestion(
      {required String userId, required String symbol}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Get token from secure storage
      final String? token = await _secureStorage.read(key: 'authToken');

      if (token == null) {
        throw Exception('Authentication token not found');
      }

      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'userId': userId,
          'symbol': symbol,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'token': token,
          },
        ),
      );

      if (response.statusCode == 200) {
        _suggestion = AISuggestion.fromJson(response.data);
        print(_suggestion);
        _error = null;
      } else {
        _error = 'Failed to fetch suggestion: ${response.statusCode}';
        _suggestion = null;
      }
    } on DioException catch (e) {
      _error = 'Network error: ${e.message}';
      _suggestion = null;
      if (kDebugMode) {
        print('Error fetching AI suggestion: $e');
      }
    } catch (e) {
      _error = 'Error: ${e.toString()}';
      _suggestion = null;
      if (kDebugMode) {
        print('Error fetching AI suggestion: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Refresh suggestion (unchanged)
  Future<void> refreshSuggestion(
      {required String userId, required String symbol}) async {
    await fetchSuggestion(userId: userId, symbol: symbol);
  }

  // Clear data (unchanged)
  void clearData() {
    _suggestion = null;
    _error = null;
    _isLoading = false;
    notifyListeners();
  }

  // Clear error (unchanged)
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
