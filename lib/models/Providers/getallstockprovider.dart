import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:hackathon_project/models/allstockclass.dart';

class AllStockProvider with ChangeNotifier {
  final Dio _dio = Dio();
  static const String _baseUrl = 'https://stockup-auz8.onrender.com';
  List<Stocks>? _stocks;
  List<Stocks>? _filteredStocks;
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';

  AllStockProvider() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  List<Stocks>? get stocks => _stocks;
  List<Stocks>? get filteredStocks => _filteredStocks;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadAllStocks(String token) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _dio.get(
        '/stockUp/stocks/all-stocks',
        data: {},
        options: Options(headers: {'token': token}),
      );

      if (response.data is Map<String, dynamic>) {
        final stockSymbol =
            StockSymbol.fromJson(response.data as Map<String, dynamic>);
        _stocks = stockSymbol.stocks;
        _filteredStocks = _stocks; // Initialize filtered stocks with all stocks
      } else {
        throw 'Invalid response format';
      }
    } on DioException catch (e) {
      _error = _handleError(e);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterStocks({String? searchQuery}) {
    _searchQuery = searchQuery?.toLowerCase() ?? '';

    if (_stocks == null) return;

    if (_searchQuery.isEmpty) {
      _filteredStocks = _stocks;
    } else {
      _filteredStocks = _stocks!.where((stock) {
        final symbol = stock.symbol?.toLowerCase() ?? '';
        final name = stock.name?.toLowerCase() ?? '';
        final exchange = stock.exchange?.toLowerCase() ?? '';
        final type = stock.type?.toLowerCase() ?? '';

        return symbol.contains(_searchQuery) ||
            name.contains(_searchQuery) ||
            exchange.contains(_searchQuery) ||
            type.contains(_searchQuery);
      }).toList();
    }
    notifyListeners();
  }

  String _handleError(DioException e) {
    if (e.response != null) {
      return 'Server error: ${e.response?.statusCode} - ${e.response?.statusMessage}';
    } else {
      return 'Network error: ${e.message}';
    }
  }

  void clearStocks() {
    _stocks = null;
    _filteredStocks = null;
    notifyListeners();
  }
}
