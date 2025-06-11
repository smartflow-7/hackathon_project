import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_project/models/Chartdata.dart';

class Chartdataprovider with ChangeNotifier {
  // Dio instance
  late Dio _dio;

  // API configuration
  static const String _baseUrl = 'https://financialmodelingprep.com/stable';
  static const String _apiKey = 'y9ChT9wn07Z8WkSfncZHSofgHZUFjdBx';

  // Data storage
  List<chartdata> _stockDataList = [];
  String _currentSymbol = 'AAPL';

  // State management
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';
  DateTime? _lastUpdated;

  // Timer for auto-refresh
  Timer? _refreshTimer;
  static const Duration _refreshInterval = Duration(minutes: 10);

  // Getters
  List<chartdata> get stockDataList => List.unmodifiable(_stockDataList);
  String get currentSymbol => _currentSymbol;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;
  DateTime? get lastUpdated => _lastUpdated;
  bool get hasData => _stockDataList.isNotEmpty;

  // Constructor
  Chartdataprovider() {
    _initializeDio();
    _startAutoRefresh();
    // Load initial data
    fetchStockData();
  }

  void _initializeDio() {
    _dio = Dio();
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);

    // Add interceptors for logging (only in debug mode)
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) => debugPrint(object.toString()),
      ));
    }

    // Add error handling interceptor
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) {
        debugPrint('Dio Error: ${error.message}');
        handler.next(error);
      },
    ));
  }

  void _startAutoRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(_refreshInterval, (timer) {
      if (!_isLoading) {
        fetchStockData(showLoading: false); // Silent refresh
      }
    });
  }

  // Fetch stock data from API
  Future<void> fetchStockData({
    String? symbol,
    bool showLoading = true,
  }) async {
    try {
      if (symbol != null) {
        _currentSymbol = symbol;
      }

      if (showLoading) {
        _setLoading(true);
      }
      _clearError();

      final response = await _dio.get(
        '/historical-price-eod/light',
        queryParameters: {
          'symbol': _currentSymbol,
          'apikey': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        await _processApiResponse(response.data);
        _lastUpdated = DateTime.now();

        if (kDebugMode) {
          debugPrint(
              'Successfully fetched ${_stockDataList.length} data points for $_currentSymbol');
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'API returned status code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      _setError('Unexpected error: $e');
    } finally {
      if (showLoading) {
        _setLoading(false);
      }
    }
  }

  Future<void> _processApiResponse(dynamic responseData) async {
    try {
      List<chartdata> newDataList = [];

      if (responseData is List) {
        // If response is directly a list
        for (var item in responseData) {
          if (item is Map<String, dynamic>) {
            // Convert any int values to double for price fields
            if (item['price'] is int) {
              item['price'] = (item['price'] as int).toDouble();
            }
            newDataList.add(chartdata.fromJson(item));
          }
        }
      } else if (responseData is Map<String, dynamic>) {
        // If response is wrapped in an object
        if (responseData.containsKey('data')) {
          List<dynamic> data = responseData['data'];
          for (var item in data) {
            if (item is Map<String, dynamic>) {
              // Convert any int values to double for price fields
              if (item['price'] is int) {
                item['price'] = (item['price'] as int).toDouble();
              }
              newDataList.add(chartdata.fromJson(item));
            }
          }
        } else {
          // Convert any int values to double for price fields
          if (responseData['price'] is int) {
            responseData['price'] = (responseData['price'] as int).toDouble();
          }
          // Try to parse the response directly
          newDataList.add(chartdata.fromJson(responseData));
        }
      }

      if (newDataList.isNotEmpty) {
        // Sort by date (newest first)
        newDataList.sort((a, b) {
          if (a.date == null || b.date == null) return 0;
          return DateTime.parse(b.date!).compareTo(DateTime.parse(a.date!));
        });

        _stockDataList = newDataList;
        notifyListeners();
      } else {
        throw Exception('No valid data found in API response');
      }
    } catch (e) {
      _setError('Error processing API response: $e');
    }
  }

  void _handleDioError(DioException e) {
    String errorMessage;

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage =
            'Connection timeout. Please check your internet connection.';
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = 'Send timeout. Please try again.';
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Receive timeout. Server is taking too long to respond.';
        break;
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 401) {
          errorMessage = 'Unauthorized. Please check your API key.';
        } else if (statusCode == 403) {
          errorMessage =
              'Forbidden. API key may have insufficient permissions.';
        } else if (statusCode == 429) {
          errorMessage =
              'Rate limit exceeded. Please wait before making another request.';
        } else if (statusCode == 500) {
          errorMessage = 'Server error. Please try again later.';
        } else {
          errorMessage =
              'HTTP Error $statusCode: ${e.response?.statusMessage ?? 'Unknown error'}';
        }
        break;
      case DioExceptionType.cancel:
        errorMessage = 'Request was cancelled.';
        break;
      case DioExceptionType.unknown:
        errorMessage = 'Network error. Please check your internet connection.';
        break;
      default:
        errorMessage = 'Unknown error occurred: ${e.message}';
    }

    _setError(errorMessage);
  }

  // Change symbol and fetch new data
  Future<void> changeSymbol(String newSymbol) async {
    if (newSymbol != _currentSymbol) {
      _currentSymbol = newSymbol.toUpperCase();
      await fetchStockData();
    }
  }

  // Manual refresh
  Future<void> refresh() async {
    await fetchStockData();
  }

  // Get latest price
  double? get latestPrice {
    if (_stockDataList.isNotEmpty) {
      return _stockDataList.first.price;
    }
    return null;
  }

  // Get price change
  double get priceChange {
    if (_stockDataList.length >= 2) {
      final latest = _stockDataList.first.price ?? 0;
      final previous = _stockDataList[1].price ?? 0;
      return latest - previous;
    }
    return 0.0;
  }

  // Get price change percentage
  double get priceChangePercent {
    if (_stockDataList.length >= 2) {
      final latest = _stockDataList.first.price ?? 0;
      final previous = _stockDataList[1].price ?? 0;
      if (previous != 0) {
        return ((latest - previous) / previous) * 100;
      }
    }
    return 0.0;
  }

  // Get data for specific date range
  List<chartdata> getDataForRange(int days) {
    if (_stockDataList.isEmpty) return [];

    final cutoffDate = DateTime.now().subtract(Duration(days: days));
    return _stockDataList.where((data) {
      final dataDate = DateTime.parse(data.date ?? '');
      return dataDate.isAfter(cutoffDate);
    }).toList();
  }

  // Private helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String message) {
    _hasError = true;
    _errorMessage = message;
    notifyListeners();
    debugPrint('StockDataProvider Error: $message');
  }

  void _clearError() {
    _hasError = false;
    _errorMessage = '';
  }

  // Dispose method to clean up resources
  @override
  void dispose() {
    _refreshTimer?.cancel();
    _dio.close();
    super.dispose();
  }

  // Stop auto refresh (useful when app goes to background)
  void stopAutoRefresh() {
    _refreshTimer?.cancel();
  }

  // Resume auto refresh
  void resumeAutoRefresh() {
    _startAutoRefresh();
  }
}
