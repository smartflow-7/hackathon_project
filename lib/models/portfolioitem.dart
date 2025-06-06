class PortfolioItem {
  final String symbol;
  final int quantity;
  final double buyPrice;
  final DateTime date;
  final String type;

  PortfolioItem({
    required this.symbol,
    required this.quantity,
    required this.buyPrice,
    required this.date,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
        'symbol': symbol,
        'quantity': quantity,
        'buyPrice': buyPrice,
        'date': date.toIso8601String(),
      };

  static PortfolioItem fromJson(Map<String, dynamic> json) => PortfolioItem(
        symbol: json['symbol'] ?? '',
        quantity: json['quantity'] ?? 0,
        buyPrice: (json['buyPrice'] ?? 0).toDouble(),
        date: json['date'] != null
            ? DateTime.parse(json['date'])
            : DateTime.now(),
        type: json['type'] ?? 'stock',
      );
}
