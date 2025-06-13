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
    // _dio.options.connectTimeout = const Duration(seconds: 30);
    //  _dio.options.receiveTimeout = const Duration(seconds: 30);

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
      final newDataList = <chartdata>[];
      final now = DateTime.now();
      final oneYearAgo = DateTime(now.year - 1, now.month, now.day);

      dynamic dataToProcess;

      if (responseData is List) {
        dataToProcess = responseData;
      } else if (responseData is Map) {
        dataToProcess =
            responseData['data'] ?? responseData['historical'] ?? responseData;
        if (dataToProcess is Map) {
          // Handle case where data is in a map format
          dataToProcess = [dataToProcess];
        }
      }

      if (dataToProcess is List) {
        for (var item in dataToProcess) {
          try {
            if (item is Map<String, dynamic>) {
              // Normalize data format
              final normalized = _normalizeDataItem(item);
              if (normalized != null) {
                newDataList.add(normalized);
              }
            }
          } catch (e) {
            debugPrint('Error processing item: $e');
          }
        }
      }

      if (newDataList.isNotEmpty) {
        // Sort and filter recent data
        newDataList.sort((a, b) {
          final aDate = a.date != null ? DateTime.parse(a.date!) : DateTime(0);
          final bDate = b.date != null ? DateTime.parse(b.date!) : DateTime(0);
          return bDate.compareTo(aDate);
        });

        // Filter to only keep recent data (adjust range as needed)
        _stockDataList = newDataList.where((data) {
          if (data.date == null) return false;
          final dataDate = DateTime.parse(data.date!);
          return dataDate.isAfter(oneYearAgo);
        }).toList();

        notifyListeners();
      } else {
        throw Exception('Received empty or invalid data for $_currentSymbol');
      }
    } catch (e) {
      _setError('Data processing error: ${e.toString()}');
      _stockDataList = [];
      notifyListeners();
      rethrow;
    }
  }

  chartdata? _normalizeDataItem(Map<String, dynamic> item) {
    try {
      // Convert all number types to double
      final normalized = Map<String, dynamic>.from(item);

      // Handle different API response formats
      normalized['price'] =
          _toDouble(item['price'] ?? item['close'] ?? item['adjClose']);
      normalized['date'] = item['date'] ?? item['timestamp'] ?? item['time'];

      // Additional normalization if needed
      if (normalized['price'] == null || normalized['date'] == null) {
        return null;
      }

      return chartdata.fromJson(normalized);
    } catch (e) {
      debugPrint('Normalization error: $e');
      return null;
    }
  }

  double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
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
  // Add these methods to your existing Chartdataprovider class

// Improved changeSymbol method
  Future<void> changeSymbol(String newSymbol) async {
    if (newSymbol.isEmpty) return;

    final cleanSymbol = newSymbol.trim().toUpperCase();
    if (cleanSymbol == _currentSymbol) return;

    try {
      _setLoading(true);
      _clearError();
      _stockDataList = []; // Clear previous data
      notifyListeners(); // Immediate UI update

      _currentSymbol = cleanSymbol;
      await fetchStockData(showLoading: false);

      // Additional validation
      if (_stockDataList.isEmpty) {
        _setError('No data available for $cleanSymbol');
      }
    } catch (e) {
      _setError('Failed to load data for $cleanSymbol: ${e.toString()}');
      _currentSymbol = cleanSymbol; // Still update symbol to show what failed
      notifyListeners();
    } finally {
      _setLoading(false);
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
