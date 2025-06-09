class StockSymbol {
  final String currency;
  final String description;
  final String displaySymbol;
  final String figi;
  final String? isin;
  final String mic;
  final String shareClassFIGI;
  final String symbol;
  final String symbol2;
  final String type;

  const StockSymbol({
    required this.currency,
    required this.description,
    required this.displaySymbol,
    required this.figi,
    this.isin,
    required this.mic,
    required this.shareClassFIGI,
    required this.symbol,
    required this.symbol2,
    required this.type,
  });

  /// Create a StockSymbol from JSON
  factory StockSymbol.fromJson(Map<String, dynamic> json) {
    return StockSymbol(
      currency: json['currency']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      displaySymbol: json['displaySymbol']?.toString() ?? '',
      figi: json['figi']?.toString() ?? '',
      isin: json['isin']?.toString(),
      mic: json['mic']?.toString() ?? '',
      shareClassFIGI: json['shareClassFIGI']?.toString() ?? '',
      symbol: json['symbol']?.toString() ?? '',
      symbol2: json['symbol2']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
    );
  }

  /// Convert StockSymbol to JSON
  Map<String, dynamic> toJson() {
    return {
      'currency': currency,
      'description': description,
      'displaySymbol': displaySymbol,
      'figi': figi,
      'isin': isin,
      'mic': mic,
      'shareClassFIGI': shareClassFIGI,
      'symbol': symbol,
      'symbol2': symbol2,
      'type': type,
    };
  }

  /// Create a copy with optional parameter changes
  StockSymbol copyWith({
    String? currency,
    String? description,
    String? displaySymbol,
    String? figi,
    String? isin,
    String? mic,
    String? shareClassFIGI,
    String? symbol,
    String? symbol2,
    String? type,
  }) {
    return StockSymbol(
      currency: currency ?? this.currency,
      description: description ?? this.description,
      displaySymbol: displaySymbol ?? this.displaySymbol,
      figi: figi ?? this.figi,
      isin: isin ?? this.isin,
      mic: mic ?? this.mic,
      shareClassFIGI: shareClassFIGI ?? this.shareClassFIGI,
      symbol: symbol ?? this.symbol,
      symbol2: symbol2 ?? this.symbol2,
      type: type ?? this.type,
    );
  }

  /// Get the primary symbol to use (displaySymbol if available, otherwise symbol)
  String get primarySymbol => displaySymbol.isNotEmpty ? displaySymbol : symbol;

  /// Get the company name (description)
  String get companyName => description;

  /// Check if this is a common stock
  bool get isCommonStock => type.toLowerCase().contains('common stock');

  /// Check if this stock has an ISIN
  bool get hasISIN => isin != null && isin!.isNotEmpty;

  /// Get a formatted display name for UI
  String get displayName => '$primarySymbol - $companyName';

  /// Get a short display name (symbol only)
  String get shortDisplayName => primarySymbol;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StockSymbol &&
        other.currency == currency &&
        other.description == description &&
        other.displaySymbol == displaySymbol &&
        other.figi == figi &&
        other.isin == isin &&
        other.mic == mic &&
        other.shareClassFIGI == shareClassFIGI &&
        other.symbol == symbol &&
        other.symbol2 == symbol2 &&
        other.type == type;
  }

  @override
  int get hashCode {
    return Object.hash(
      currency,
      description,
      displaySymbol,
      figi,
      isin,
      mic,
      shareClassFIGI,
      symbol,
      symbol2,
      type,
    );
  }

  @override
  String toString() {
    return 'StockSymbol(symbol: $symbol, displaySymbol: $displaySymbol, description: $description, currency: $currency, type: $type)';
  }

  /// Create a list of StockSymbol from a JSON array
  static List<StockSymbol> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .whereType<Map<String, dynamic>>()
        .map((json) => StockSymbol.fromJson(json))
        .toList();
  }

  /// Convert a list of StockSymbol to JSON array
  static List<Map<String, dynamic>> toJsonList(List<StockSymbol> symbols) {
    return symbols.map((symbol) => symbol.toJson()).toList();
  }
}
