import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hackathon_project/models/allstockclass.dart';
import 'package:hackathon_project/models/portfolioitem.dart';
import 'package:hackathon_project/models/stock_model.dart';

class StockService {
  final Dio _dio = Dio();
  static const String _baseUrl = 'https://stockup-auz8.onrender.com';

  StockService() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  String _handleError(DioException e) {
    if (e.response?.data is Map && e.response?.data['message'] != null) {
      return e.response!.data['message'];
    }
    return e.message ?? 'An unknown error occurred';
  }

  Future<Map<String, dynamic>> searchStock(String symbol, String token) async {
    try {
      final response = await _dio.get(
        '/stockUp/stocks/search?query=$symbol',
        // queryParameters: {'query': symbol},
        options: Options(headers: {'token': token}),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> buyStock({
    required String symbol,
    required int quantity,
    required String token,
  }) async {
    try {
      final response = await _dio.post(
        '/stockUp/stocks/buy',
        data: {'symbol': symbol, 'quantity': quantity},
        options: Options(headers: {'token': token}),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> sellStock({
    required String symbol,
    required int quantity,
    required String token,
  }) async {
    try {
      final response = await _dio.post(
        '/stockUp/stocks/sell',
        data: {'symbol': symbol, 'quantity': quantity},
        options: Options(headers: {'token': token}),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> getPortfolio(String token) async {
    try {
      final response = await _dio.get(
        '/stockUp/stocks/portfolio',
        data: {},
        options: Options(headers: {'token': token}),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<StockSymbol> getAllstocks(String token) async {
    try {
      final response = await _dio.get(
        '/stockUp/stocks/all-stocks',
        data: {},
        options: Options(headers: {'token': token}),
      );

      if (response.data is Map<String, dynamic>) {
        print('response is');
        print(response.data);
        return StockSymbol.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw 'Invalid response format';
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
}

class StockProvider extends ChangeNotifier {
  final StockService _stockService = StockService();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // State
  List<PortfolioItem> portfolio = [];
  List<String> watchlist = [];
  final Map<String, StockData> stockCache = {};
  List<Stocks> allStocks = [];
  List<Stocks> filteredStocks = [];
  final Map<String, Stocks> stocksCache = {};

  double balance = 0.0;
  bool isLoading = false;
  String percentageChange = '0.0%';
  double totalbalance = 0;
  String? error;
  bool autoRefreshEnabled = true;
  double portbalance = 0.0;

  // Timers
  Timer? _refreshTimer;
  static const _refreshInterval = Duration(seconds: 5);
  Timer? _portfolioValueTimer;
  static const _portfolioUpdateInterval = Duration(seconds: 60);
  double _cachedPortfolioValue = 0.0;
  double _cachedPortfolioChange = 0.0;

  Future<void> initialize() async {
    debugPrint('=== Initialize Method Start ===');

    await _loadFromStorage();
    final token = await _storage.read(key: 'auth_token');

    if (token != null) {
      await refreshPortfolio(token);
      await loadAllStocks(token); // This will now always fetch fresh data
    }

    _refreshTimer?.cancel();
    _portfolioValueTimer?.cancel();

    startAutoRefresh();
    _startPortfolioValueUpdates();

    _refreshPrices();
    _updatePortfolioValues();

    debugPrint('=== Initialize Method End ===');
  }

  // =============== Portfolio Management ===============
  Future<void> refreshPortfolio(String token) async {
    _setLoading(true);
    try {
      final response = await _stockService.getPortfolio(token);

      if (response['success'] == true) {
        balance = (response['balance'] ?? response['data']?['balance'] ?? 0.0)
            .toDouble();
        percentageChange = (response['percentage'] ?? '0.0%').toString();
        totalbalance = (response['TotalBalance'] ?? 0.0).toDouble();

        final portfolioData = response['Portfolio'] ??
            response['portfolio'] ??
            response['data']?['Portfolio'] ??
            response['data']?['portfolio'];

        portfolio = (portfolioData as List?)?.map((item) {
              return PortfolioItem.fromJson(
                  (item as Map).cast<String, dynamic>());
            }).toList() ??
            [];

        await _savePortfolioToStorage();
        _updatePortfolioValues();
      } else {
        throw response['message'] ?? 'Failed to fetch portfolio';
      }
    } catch (e) {
      error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // =============== Stock Operations ===============
  Future<Map<String, dynamic>> buyStock({
    required String symbol,
    required int quantity,
    required String token,
  }) async {
    _setLoading(true);
    try {
      final response = await _stockService.buyStock(
        symbol: symbol.toUpperCase(),
        quantity: quantity,
        token: token,
      );

      if (response['success'] == true) {
        await refreshPortfolio(token);
        return {
          'success': true,
          'message': response['message'] ?? 'Buy successful'
        };
      } else {
        return {
          'success': false,
          'message': response['message'] ?? 'Buy failed'
        };
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    } finally {
      _setLoading(false);
    }
  }

  Future<Map<String, dynamic>> sellStock({
    required String symbol,
    required int quantity,
    required String token,
  }) async {
    _setLoading(true);
    try {
      final response = await _stockService.sellStock(
        symbol: symbol.toUpperCase(),
        quantity: quantity,
        token: token,
      );

      if (response['success'] == true) {
        await refreshPortfolio(token);
        return {
          'success': true,
          'message': response['message'] ?? 'Sell successful'
        };
      } else {
        return {
          'success': false,
          'message': response['message'] ?? 'Sell failed'
        };
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    } finally {
      _setLoading(false);
    }
  }

  Future<StockData?> searchStock(String query, String token) async {
    if (query.isEmpty) return null;

    final upperQuery = query.toUpperCase();

    // Check cache first
    if (stockCache.containsKey(upperQuery)) {
      return stockCache[upperQuery];
    }

    _setLoading(true);
    try {
      final response = await _stockService.searchStock(upperQuery, token);

      debugPrint('Search Stock Response: ${response.toString()}');

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'] as Map<String, dynamic>;

        // Create StockData from response
        final stockData = StockData.fromJson({
          ...data,
          'symbol': upperQuery,
          'name': upperQuery, // Using symbol as name if not provided
          'exchange': 'N/A', // Default value if not provided
          't': DateTime.now().millisecondsSinceEpoch ~/
              1000, // Current timestamp if not provided
        });

        // Cache the result
        stockCache[upperQuery] = stockData;
        notifyListeners();

        return stockData;
      } else {
        error = response['message'] ?? 'Stock not found';
        notifyListeners();
        return null;
      }
    } catch (e) {
      debugPrint('Error in searchStock: $e');
      error = 'Failed to fetch stock data: ${e.toString()}';
      notifyListeners();
      return null;
    } finally {
      _setLoading(false);
    }
  }

  // =============== All Stocks Management ===============
  Future<void> loadAllStocks(String token) async {
    _setLoading(true);
    try {
      final stockSymbol = await _stockService.getAllstocks(token);

      if (stockSymbol.success == true && stockSymbol.stocks != null) {
        // Clear existing data
        allStocks.clear();
        filteredStocks.clear();
        stocksCache.clear();

        // Set new data
        allStocks = stockSymbol.stocks!;
        filteredStocks = List.from(allStocks);

        // Update cache
        for (final stock in allStocks) {
          if (stock.symbol != null) {
            stocksCache[stock.symbol!.toUpperCase()] = stock;
          }
        }

        error = null;
      } else {
        error = 'Failed to fetch stocks';
      }
    } catch (e) {
      error = e.toString();
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  void filterStocksBySymbol(String query) {
    if (query.isEmpty) {
      filteredStocks = List.from(allStocks);
    } else {
      final upperQuery = query.toUpperCase();
      filteredStocks = allStocks.where((stock) {
        final symbol = stock.symbol?.toUpperCase() ?? '';
        final name = stock.name?.toUpperCase() ?? '';
        return symbol.contains(upperQuery) || name.contains(upperQuery);
      }).toList();
    }
    notifyListeners();
  }

  void filterStocks({
    String? symbol,
    String? name,
    String? exchange,
    String? type,
    double? minPrice,
    double? maxPrice,
  }) {
    filteredStocks = allStocks.where((stock) {
      if (symbol != null && symbol.isNotEmpty) {
        final stockSymbol = stock.symbol?.toUpperCase() ?? '';
        if (!stockSymbol.contains(symbol.toUpperCase())) return false;
      }

      if (name != null && name.isNotEmpty) {
        final stockName = stock.name?.toUpperCase() ?? '';
        if (!stockName.contains(name.toUpperCase())) return false;
      }

      if (exchange != null && exchange.isNotEmpty) {
        final stockExchange = stock.exchange?.toUpperCase() ?? '';
        if (!stockExchange.contains(exchange.toUpperCase())) return false;
      }

      if (type != null && type.isNotEmpty) {
        final stockType = stock.type?.toUpperCase() ?? '';
        if (!stockType.contains(type.toUpperCase())) return false;
      }

      if (stock.price != null) {
        if (minPrice != null && stock.price! < minPrice) return false;
        if (maxPrice != null && stock.price! > maxPrice) return false;
      }

      return true;
    }).toList();

    notifyListeners();
  }

  void sortStocks({
    required String sortBy,
    required bool ascending,
  }) {
    filteredStocks.sort((a, b) {
      int comparison = 0;

      switch (sortBy.toLowerCase()) {
        case 'symbol':
          comparison = (a.symbol ?? '').compareTo(b.symbol ?? '');
          break;
        case 'name':
          comparison = (a.name ?? '').compareTo(b.name ?? '');
          break;
        case 'price':
          comparison = (a.price ?? 0).compareTo(b.price ?? 0);
          break;
        case 'exchange':
          comparison = (a.exchange ?? '').compareTo(b.exchange ?? '');
          break;
        default:
          comparison = (a.symbol ?? '').compareTo(b.symbol ?? '');
      }

      return ascending ? comparison : -comparison;
    });

    notifyListeners();
  }

  Stocks? getStockBySymbol(String symbol) {
    return stocksCache[symbol.toUpperCase()];
  }

  void clearFilters() {
    filteredStocks = List.from(allStocks);
    notifyListeners();
  }

  List<Stocks> getStocksByExchange(String exchange) {
    return allStocks
        .where(
            (stock) => stock.exchange?.toUpperCase() == exchange.toUpperCase())
        .toList();
  }

  List<Stocks> getStocksByType(String type) {
    return allStocks
        .where((stock) => stock.type?.toUpperCase() == type.toUpperCase())
        .toList();
  }

  // =============== Price Refresh ===============
  void startAutoRefresh() {
    if (autoRefreshEnabled) return;

    autoRefreshEnabled = true;
    _refreshTimer?.cancel();

    _refreshPrices();
    _refreshTimer = Timer.periodic(_refreshInterval, (_) => _refreshPrices());
    notifyListeners();
  }

  void stopAutoRefresh() {
    autoRefreshEnabled = false;
    _refreshTimer?.cancel();
    notifyListeners();
  }

  Future<void> _refreshPrices() async {
    if (isLoading) return;

    final symbols = {...portfolio.map((p) => p.symbol), ...watchlist}.toList();
    if (symbols.isEmpty) return;

    final token = await _storage.read(key: 'auth_token');
    if (token == null) return;

    bool pricesUpdated = false;

    try {
      await Future.wait(symbols.map((symbol) async {
        try {
          final response = await _stockService.searchStock(symbol, token);
          if (response['success'] == true && response['data'] != null) {
            final newPrice = response['data']['currentPrice']?.toDouble();
            final cachedPrice = stockCache[symbol]?.currentPrice;

            if (newPrice != null && newPrice != cachedPrice) {
              stockCache[symbol] = StockData.fromJson({
                ...response['data'],
                'symbol': symbol,
              });
              pricesUpdated = true;
            }
          }
        } catch (e) {
          debugPrint('Error refreshing $symbol: $e');
        }
      }));

      if (pricesUpdated) {
        _updatePortfolioValues();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error in price refresh: $e');
    }
  }

  Future<void> manualRefresh() async {
    final token = await _storage.read(key: 'auth_token');
    if (token != null) {
      await _refreshPrices();
      await refreshPortfolio(token);
      notifyListeners();
    }
  }

  // =============== Portfolio Value Updates ===============
  void _startPortfolioValueUpdates() {
    _portfolioValueTimer?.cancel();
    _portfolioValueTimer = Timer.periodic(_portfolioUpdateInterval, (_) {
      _updatePortfolioValues();
    });
    _updatePortfolioValues();
  }

  void _updatePortfolioValues() {
    final newValue = _calculatePortfolioValue();
    final newChange = _calculatePortfolioChange();

    if (newValue != _cachedPortfolioValue ||
        newChange != _cachedPortfolioChange) {
      _cachedPortfolioValue = newValue;
      _cachedPortfolioChange = newChange;
      notifyListeners();
    }
  }

  double get portfolioValue => _cachedPortfolioValue;
  double get portfolioChange => _cachedPortfolioChange;

  double _calculatePortfolioValue() {
    double totalValue = 0.0;

    final ownedStocks = <String, int>{};
    final stockCosts = <String, double>{};

    for (final item in portfolio) {
      if (item.type == 'buy') {
        ownedStocks.update(
          item.symbol,
          (quantity) => quantity + item.quantity,
          ifAbsent: () => item.quantity,
        );
        stockCosts.update(
          item.symbol,
          (cost) => cost + (item.quantity * item.buyPrice),
          ifAbsent: () => item.quantity * item.buyPrice,
        );
      } else if (item.type == 'sell') {
        ownedStocks.update(
          item.symbol,
          (quantity) => quantity - item.quantity,
          ifAbsent: () => -item.quantity,
        );
        if (stockCosts.containsKey(item.symbol)) {
          final avgCostBasis = stockCosts[item.symbol]! /
              (ownedStocks[item.symbol]! + item.quantity);
          stockCosts[item.symbol] =
              stockCosts[item.symbol]! - (item.quantity * avgCostBasis);
        }
      }
    }

    ownedStocks.forEach((symbol, quantity) {
      if (quantity > 0) {
        final currentPrice = stockCache[symbol]?.currentPrice;
        if (currentPrice != null && currentPrice > 0) {
          totalValue += quantity * currentPrice;
        } else {
          final avgPrice = getAverageBuyPrice(symbol);
          if (avgPrice > 0) {
            totalValue += quantity * avgPrice;
          }
        }
      }
    });

    return totalValue;
  }

  double _calculatePortfolioChange() {
    double change = 0.0;

    final holdings = <String, int>{};
    final costs = <String, double>{};

    for (final item in portfolio) {
      final quantity = item.type == 'buy' ? item.quantity : -item.quantity;
      holdings.update(
        item.symbol,
        (value) => value + quantity,
        ifAbsent: () => quantity,
      );

      if (item.type == 'buy') {
        costs.update(
          item.symbol,
          (value) => value + (item.quantity * item.buyPrice),
          ifAbsent: () => item.quantity * item.buyPrice,
        );
      }
    }

    holdings.forEach((symbol, quantity) {
      if (quantity > 0) {
        final currentPrice = stockCache[symbol]?.currentPrice;
        if (currentPrice != null && costs.containsKey(symbol)) {
          final avgCost = costs[symbol]! / quantity;
          change += (currentPrice - avgCost) * quantity;
        }
      }
    });

    return change;
  }

  // =============== Watchlist Management ===============
  Future<void> toggleWatchlist(String symbol) async {
    final upperSymbol = symbol.toUpperCase();
    if (watchlist.contains(upperSymbol)) {
      watchlist.remove(upperSymbol);
    } else {
      watchlist.add(upperSymbol);
    }
    await _saveWatchlistToStorage();
    notifyListeners();
  }

  bool isWatching(String symbol) {
    return watchlist.contains(symbol.toUpperCase());
  }

  // =============== Helpers ===============
  int getHoldings(String symbol) {
    var holdings = 0;
    for (final item
        in portfolio.where((p) => p.symbol == symbol.toUpperCase())) {
      holdings += item.type == 'buy' ? item.quantity : -item.quantity;
    }
    return holdings > 0 ? holdings : 0;
  }

  double getAverageBuyPrice(String symbol) {
    final buys = portfolio
        .where((p) => p.symbol == symbol.toUpperCase() && p.type == 'buy');

    if (buys.isEmpty) return 0.0;

    final totalQuantity = buys.fold(0, (sum, item) => sum + item.quantity);
    final totalCost =
        buys.fold(0.0, (sum, item) => sum + (item.quantity * item.buyPrice));

    return totalCost / totalQuantity;
  }

  // =============== Storage ===============
  Future<void> _loadFromStorage() async {
    try {
      // Load portfolio
      final portfolioData = await _storage.read(key: 'portfolio_data');
      if (portfolioData != null) {
        portfolio = (jsonDecode(portfolioData) as List)
            .map((e) => PortfolioItem.fromJson(e))
            .toList();
      }

      // Load watchlist
      final watchlistData = await _storage.read(key: 'watchlist_data');
      if (watchlistData != null) {
        watchlist = List<String>.from(jsonDecode(watchlistData));
      }

      // Note: We're no longer loading allStocks from storage
    } catch (e) {
      debugPrint('Error loading from storage: $e');
    }
  }

  Future<void> _savePortfolioToStorage() async {
    await _storage.write(
      key: 'portfolio_data',
      value: jsonEncode(portfolio.map((p) => p.toJson()).toList()),
    );
  }

  Future<void> _saveWatchlistToStorage() async {
    await _storage.write(
      key: 'watchlist_data',
      value: jsonEncode(watchlist),
    );
  }

  // =============== State Management ===============
  void _setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  Future<void> clearData() async {
    portfolio.clear();
    watchlist.clear();
    stockCache.clear();
    stocksCache.clear();
    allStocks.clear();
    filteredStocks.clear();
    balance = 0.0;
    error = null;
    _cachedPortfolioValue = 0.0;
    _cachedPortfolioChange = 0.0;

    await _storage.delete(key: 'portfolio_data');
    await _storage.delete(key: 'watchlist_data');

    notifyListeners();
  }
}
