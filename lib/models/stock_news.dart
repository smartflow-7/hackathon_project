class Stocknews {
  bool? success;
  List<News>? news;

  Stocknews({this.success, this.news});

  Stocknews.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['news'] != null) {
      news = <News>[];
      json['news'].forEach((v) {
        news!.add(News.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (news != null) {
      data['news'] = news!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class News {
  String? category;
  int? datetime;
  String? headline;
  int? id;
  String? image;
  String? related;
  String? source;
  String? summary;
  String? url;

  News(
      {this.category,
      this.datetime,
      this.headline,
      this.id,
      this.image,
      this.related,
      this.source,
      this.summary,
      this.url});

  News.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    datetime = json['datetime'];
    headline = json['headline'];
    id = json['id'];
    image = json['image'];
    related = json['related'];
    source = json['source'];
    summary = json['summary'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['datetime'] = datetime;
    data['headline'] = headline;
    data['id'] = id;
    data['image'] = image;
    data['related'] = related;
    data['source'] = source;
    data['summary'] = summary;
    data['url'] = url;
    return data;
  }
}
