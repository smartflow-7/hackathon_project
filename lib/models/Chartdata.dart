class chartdata {
  String? symbol;
  String? date;
  double? price;
  int? volume;

  chartdata({this.symbol, this.date, this.price, this.volume});

  chartdata.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    date = json['date'];
    price = json['price'];
    volume = json['volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['date'] = date;
    data['price'] = price;
    data['volume'] = volume;
    return data;
  }
}
