class StockData {
  final String symbol;
  final double currentPrice;
  final double open;
  final double high;
  final double low;
  final double previousClose;
  final DateTime timestamp;

  StockData({
    required this.symbol,
    required this.currentPrice,
    required this.open,
    required this.high,
    required this.low,
    required this.previousClose,
    required this.timestamp,
  });

  factory StockData.fromJson(Map<String, dynamic> json) {
    return StockData(
      symbol: json['symbol'] ?? '',
      currentPrice: (json['c'] ?? 0.0).toDouble(),
      open: (json['o'] ?? 0.0).toDouble(),
      high: (json['h'] ?? 0.0).toDouble(),
      low: (json['l'] ?? 0.0).toDouble(),
      previousClose: (json['pc'] ?? 0.0).toDouble(),
      timestamp: DateTime.fromMillisecondsSinceEpoch((json['t'] ?? 0) * 1000),
    );
  }

  double get changeAmount => currentPrice - previousClose;
  double get changePercentage => ((changeAmount / previousClose) * 100);
  bool get isPositive => changeAmount >= 0;
}
