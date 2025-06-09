// providers/leaderboard_provider.dart
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hackathon_project/models/leaderboardmodel.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final _storage = const FlutterSecureStorage();
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://stockup-auz8.onrender.com',
    connectTimeout: const Duration(seconds: 120),
    receiveTimeout: const Duration(seconds: 120),
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  Future<LeaderboardResponse> getLeaderboard() async {
    try {
      // Get fresh token each time to avoid stale token issues
      final token = await _storage.read(key: 'auth_token');

      final response = await _dio.get(
        '/stockUp/leaderboard/',
        data: {},
        options: Options(headers: {'token': token}),
      );
      return LeaderboardResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to fetch leaderboard: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}

enum LeaderboardState { loading, loaded, error, refreshing }

class LeaderboardProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  // State variables
  List<LeaderboardUser> _users = [];
  LeaderboardState _state = LeaderboardState.loading;
  String _errorMessage = '';

  // Auto-refresh variables
  Timer? _refreshTimer;
  bool _autoRefreshEnabled = false;
  static const Duration _refreshInterval = Duration(seconds: 10);
  DateTime? _lastRefreshTime;

  // Getters
  List<LeaderboardUser> get users => _users;
  LeaderboardState get state => _state;
  String get errorMessage => _errorMessage;
  bool get autoRefreshEnabled => _autoRefreshEnabled;
  DateTime? get lastRefreshTime => _lastRefreshTime;

  // Get time since last refresh
  String get timeSinceLastRefresh {
    if (_lastRefreshTime == null) return 'Never';

    final difference = DateTime.now().difference(_lastRefreshTime!);
    if (difference.inSeconds < 60) {
      return '${difference.inSeconds}s ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else {
      return '${difference.inHours}h ago';
    }
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  /// Initialize the provider - call this when the provider is first created
  Future<void> initialize() async {
    await fetchLeaderboard();
    startAutoRefresh();
  }

  /// Fetch leaderboard data (initial load)
  Future<void> fetchLeaderboard() async {
    _state = LeaderboardState.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await _apiService.getLeaderboard();
      if (response.success) {
        _users = response.leaderboard;
        _state = LeaderboardState.loaded;
        _errorMessage = '';
        _lastRefreshTime = DateTime.now();
      } else {
        _state = LeaderboardState.error;
        _errorMessage = response.message;
      }
    } catch (e) {
      _state = LeaderboardState.error;
      _errorMessage = e.toString();
      debugPrint('Leaderboard fetch error: $e');
    }
    notifyListeners();
  }

  /// Refresh leaderboard data (background refresh)
  Future<void> _refreshLeaderboardSilently() async {
    // Don't show loading state for background refresh
    final previousState = _state;

    try {
      final response = await _apiService.getLeaderboard();
      if (response.success) {
        // Only update if data actually changed to avoid unnecessary rebuilds
        if (_hasDataChanged(response.leaderboard)) {
          _users = response.leaderboard;
          _lastRefreshTime = DateTime.now();

          // Only notify if we're not in an error state
          if (_state != LeaderboardState.error) {
            _state = LeaderboardState.loaded;
            _errorMessage = '';
          }
          notifyListeners();
        } else {
          // Update timestamp even if data hasn't changed
          _lastRefreshTime = DateTime.now();
        }
      } else {
        // Only show error if this is the first error or error message changed
        if (_errorMessage != response.message) {
          _state = LeaderboardState.error;
          _errorMessage = response.message;
          notifyListeners();
        }
      }
    } catch (e) {
      final errorMessage = e.toString();
      // Only show error if this is the first error or error message changed
      if (_errorMessage != errorMessage) {
        _state = LeaderboardState.error;
        _errorMessage = errorMessage;
        notifyListeners();
      }
      debugPrint('Leaderboard silent refresh error: $e');
    }
  }

  /// Manual refresh (with loading state)
  Future<void> refreshLeaderboard() async {
    if (_state == LeaderboardState.loading)
      return; // Prevent multiple simultaneous refreshes

    _state = LeaderboardState.refreshing;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await _apiService.getLeaderboard();
      if (response.success) {
        _users = response.leaderboard;
        _state = LeaderboardState.loaded;
        _errorMessage = '';
        _lastRefreshTime = DateTime.now();
      } else {
        //_state = LeaderboardState.error;
        _errorMessage = response.message;
      }
    } catch (e) {
      _state = LeaderboardState.error;
      _errorMessage = e.toString();
      debugPrint('Leaderboard manual refresh error: $e');
    }
    notifyListeners();
  }

  /// Start auto-refresh timer
  void startAutoRefresh() {
    if (_autoRefreshEnabled) return;

    _autoRefreshEnabled = true;
    _refreshTimer?.cancel();

    _refreshTimer = Timer.periodic(_refreshInterval, (timer) {
      _refreshLeaderboardSilently();
    });

    notifyListeners();
    debugPrint(
        'Leaderboard auto-refresh started (${_refreshInterval.inSeconds}s interval)');
  }

  /// Stop auto-refresh timer
  void stopAutoRefresh() {
    _autoRefreshEnabled = false;
    _refreshTimer?.cancel();
    _refreshTimer = null;
    notifyListeners();
    debugPrint('Leaderboard auto-refresh stopped');
  }

  /// Toggle auto-refresh on/off
  void toggleAutoRefresh() {
    if (_autoRefreshEnabled) {
      stopAutoRefresh();
    } else {
      startAutoRefresh();
    }
  }

  /// Check if leaderboard data has actually changed
  bool _hasDataChanged(List<LeaderboardUser> newUsers) {
    if (_users.length != newUsers.length) return true;

    for (int i = 0; i < _users.length; i++) {
      final oldUser = _users[i];
      final newUser = newUsers[i];

      // Compare key fields that matter for display
      if (oldUser.name != newUser.name ||
          oldUser.totalBalance != newUser.totalBalance) {
        return true;
      }
    }

    return false;
  }

  /// Get user rank by username
  // int? getUserRank(String username) {
  //   try {
  //     final user = _users.firstWhere(
  //       (user) => user.name.toLowerCase() == username.toLowerCase(),
  //     );
  //     return user.rank;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  /// Get top N users
  List<LeaderboardUser> getTopUsers(int count) {
    return _users.take(count).toList();
  }

  /// Force immediate refresh (useful for pull-to-refresh)
  Future<void> forceRefresh() async {
    _refreshTimer?.cancel(); // Cancel current timer
    await refreshLeaderboard();
    if (_autoRefreshEnabled) {
      startAutoRefresh(); // Restart timer
    }
  }

  /// Clear data and reset state
  void clearData() {
    _users.clear();
    _state = LeaderboardState.loading;
    _errorMessage = '';
    _lastRefreshTime = null;
    stopAutoRefresh();
    notifyListeners();
  }

  /// Retry after error
  Future<void> retry() async {
    await fetchLeaderboard();
    if (_autoRefreshEnabled) {
      startAutoRefresh();
    }
  }
}
