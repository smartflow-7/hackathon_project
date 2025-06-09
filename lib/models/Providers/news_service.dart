import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_project/models/stock_news.dart';

class NewsService {
  final Dio _dio = Dio();
  static const String _baseUrl =
      'https://stockup-auz8.onrender.com'; // Replace with your actual API base URL

  NewsService() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  // Helper method to handle API errors
  String _handleError(DioException e) {
    if (e.response?.data is Map && e.response?.data['message'] != null) {
      return e.response!.data['message'];
    }
    return e.message ?? 'An unknown error occurred';
  }

  // Get stock news
  Future<Stocknews> getStockNews(
      {required String token, String? symbol}) async {
    try {
      final response = await _dio.get(
        '/stockUp/news/', // Replace with your actual news endpoint
        data: {},
        options: Options(headers: {'token': token}),
      );

      if (response.statusCode == 200) {
        return Stocknews.fromJson(response.data);
      } else {
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw 'Failed to fetch news: ${e.toString()}';
    }
  }

  // Get news for a specific stock
  Future<Stocknews> getNewsForStock({
    required String token,
    required String symbol,
  }) async {
    return getStockNews(token: token, symbol: symbol);
  }

  // Get general market news
  Future<Stocknews> getMarketNews({required String token}) async {
    return getStockNews(token: token);
  }
}

class NewsProvider extends ChangeNotifier {
  final NewsService _newsService = NewsService();

  // State variables
  Stocknews? _allNews;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  Stocknews? get allNews => _allNews;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;
  bool get hasData => _allNews != null;

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Fetch all stock news
  Future<void> fetchAllNews(
      {required String token, bool refresh = false}) async {
    // Don't fetch if already loading or data exists and not refreshing
    if (_isLoading || (_allNews != null && !refresh)) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _allNews = await _newsService.getStockNews(token: token);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      _allNews = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Refresh all news data
  Future<void> refreshNews({required String token}) async {
    await fetchAllNews(token: token, refresh: true);
  }

  // Clear all cached data
  void clearData() {
    _allNews = null;
    _errorMessage = null;
    notifyListeners();
  }
}
