class StockSymbol {
  bool? success;
  List<Stocks>? stocks;

  StockSymbol({this.success, this.stocks});

  StockSymbol.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['stocks'] != null) {
      stocks = <Stocks>[];
      json['stocks'].forEach((v) {
        stocks!.add(Stocks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (stocks != null) {
      data['stocks'] = stocks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stocks {
  String? symbol;
  String? name;
  double? price;
  String? exchange;
  String? exchangeShortName;
  String? type;

  Stocks(
      {this.symbol,
      this.name,
      this.price,
      this.exchange,
      this.exchangeShortName,
      this.type});

  Stocks.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    name = json['name'];
    price = json['price']?.toDouble();
    exchange = json['exchange'];
    exchangeShortName = json['exchangeShortName'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['name'] = name;
    data['price'] = price;
    data['exchange'] = exchange;
    data['exchangeShortName'] = exchangeShortName;
    data['type'] = type;
    return data;
  }
}
