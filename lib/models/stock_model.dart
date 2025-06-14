class StockData {
  final String symbol;
  final String name;
  final String exchange;
  final double currentPrice;
  final double open;
  final double high;
  final double low;
  final double previousClose;
  final double changeAmount; // Added from 'd' in JSON
  final double changePercent; // Added from 'dp' in JSON
  final DateTime timestamp;

  StockData({
    required this.symbol,
    required this.name,
    required this.exchange,
    required this.currentPrice,
    required this.open,
    required this.high,
    required this.low,
    required this.previousClose,
    required this.changeAmount,
    required this.changePercent,
    required this.timestamp,
  });

  factory StockData.fromJson(Map<String, dynamic> json) {
    return StockData(
      symbol: json['symbol']?.toString() ?? '',
      name: json['name']?.toString() ?? json['symbol']?.toString() ?? 'Unknown',
      exchange: json['exchange']?.toString() ?? 'N/A',
      currentPrice: (json['c'] ?? json['currentPrice'] ?? 0.0).toDouble(),
      open: (json['o'] ?? json['open'] ?? 0.0).toDouble(),
      high: (json['h'] ?? json['high'] ?? 0.0).toDouble(),
      low: (json['l'] ?? json['low'] ?? 0.0).toDouble(),
      previousClose: (json['pc'] ?? json['previousClose'] ?? 0.0).toDouble(),
      changeAmount: (json['d'] ?? (json['c'] - json['pc']) ?? 0.0).toDouble(),
      changePercent:
          (json['dp'] ?? ((json['c'] - json['pc']) / json['pc'] * 100) ?? 0.0)
              .toDouble(),
      timestamp: json['t'] != null
          ? DateTime.fromMillisecondsSinceEpoch((json['t'] as int) * 1000)
          : DateTime.now(),
    );
  }

  // Keep your existing getters for backward compatibility
  bool get isPositive => changeAmount >= 0;

  // You can now use either:
  // - changeAmount (direct field from API)
  // OR
  // - calculatedChangeAmount (from original getter)
  double get calculatedChangeAmount => currentPrice - previousClose;

  double get calculatedChangePercentage => previousClose != 0
      ? ((calculatedChangeAmount / previousClose) * 100)
      : 0.0;
}
