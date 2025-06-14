class NigerianStock {
  final String symbol;
  final String name;
  final double price;
  final String sector;

  NigerianStock({
    required this.symbol,
    required this.name,
    required this.price,
    required this.sector,
  });

  // Factory constructor to create NigerianStock from JSON
  factory NigerianStock.fromJson(Map<String, dynamic> json) {
    return NigerianStock(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      sector: json['sector'] as String,
    );
  }

  // Method to convert NigerianStock to JSON
  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'name': name,
      'price': price,
      'sector': sector,
    };
  }

  @override
  String toString() {
    return 'NigerianStock(symbol: $symbol, name: $name, price: ₦${price.toStringAsFixed(2)}, sector: $sector)';
  }
}

// List containing all Nigerian stocks data
List<NigerianStock> nigerianStocks = [
  // First batch of stocks
  NigerianStock(
    symbol: "MTNN",
    name: "MTN Nigeria Communications PLC",
    price: 215.50,
    sector: "Telecommunications",
  ),
  NigerianStock(
    symbol: "GTCO",
    name: "Guaranty Trust Holding Company PLC",
    price: 42.30,
    sector: "Banking",
  ),
  NigerianStock(
    symbol: "ZENITHBANK",
    name: "Zenith Bank PLC",
    price: 39.75,
    sector: "Banking",
  ),
  NigerianStock(
    symbol: "DANGCEM",
    name: "Dangote Cement PLC",
    price: 290.00,
    sector: "Construction",
  ),
  NigerianStock(
    symbol: "BUACEMENT",
    name: "BUA Cement PLC",
    price: 112.00,
    sector: "Construction",
  ),
  NigerianStock(
    symbol: "SEPLAT",
    name: "Seplat Energy PLC",
    price: 1385.00,
    sector: "Oil & Gas",
  ),
  NigerianStock(
    symbol: "NB",
    name: "Nigerian Breweries PLC",
    price: 35.20,
    sector: "Consumer Goods",
  ),
  NigerianStock(
    symbol: "FBNH",
    name: "FBN Holdings PLC",
    price: 24.80,
    sector: "Banking",
  ),
  NigerianStock(
    symbol: "UBA",
    name: "United Bank for Africa PLC",
    price: 21.55,
    sector: "Banking",
  ),
  NigerianStock(
    symbol: "ACCESSCORP",
    name: "Access Holdings PLC",
    price: 20.90,
    sector: "Banking",
  ),

  // Second batch of stocks
  NigerianStock(
    symbol: "WAPCO",
    name: "Lafarge Africa PLC",
    price: 31.70,
    sector: "Construction",
  ),
  NigerianStock(
    symbol: "STANBIC",
    name: "Stanbic IBTC Holdings PLC",
    price: 68.50,
    sector: "Financial Services",
  ),
  NigerianStock(
    symbol: "FIDELITYBK",
    name: "Fidelity Bank PLC",
    price: 12.95,
    sector: "Banking",
  ),
  NigerianStock(
    symbol: "NASCON",
    name: "NASCON Allied Industries PLC",
    price: 45.60,
    sector: "Consumer Goods",
  ),
  NigerianStock(
    symbol: "GUINNESS",
    name: "Guinness Nigeria PLC",
    price: 58.20,
    sector: "Beverages",
  ),
  NigerianStock(
    symbol: "NESTLE",
    name: "Nestlé Nigeria PLC",
    price: 1200.00,
    sector: "Consumer Goods",
  ),
  NigerianStock(
    symbol: "CADBURY",
    name: "Cadbury Nigeria PLC",
    price: 19.50,
    sector: "Consumer Goods",
  ),
  NigerianStock(
    symbol: "ETERNA",
    name: "Eterna PLC",
    price: 13.80,
    sector: "Oil & Gas",
  ),
  NigerianStock(
    symbol: "OANDO",
    name: "Oando PLC",
    price: 10.10,
    sector: "Oil & Gas",
  ),
  NigerianStock(
    symbol: "CHIPLC",
    name: "Consolidated Hallmark Insurance PLC",
    price: 0.85,
    sector: "Insurance",
  ),
  NigerianStock(
    symbol: "INTBREW",
    name: "International Breweries PLC",
    price: 4.25,
    sector: "Consumer Goods",
  ),
  NigerianStock(
    symbol: "FCMB",
    name: "First City Monument Bank PLC",
    price: 6.30,
    sector: "Banking",
  ),
];
