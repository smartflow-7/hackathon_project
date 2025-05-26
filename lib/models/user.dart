import 'package:hackathon_project/models/portfolioitem.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final double balance;
  final List<PortfolioItem> portfolio;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.balance,
    this.portfolio = const [],
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'password': password,
        'balance': balance,
        'portfolio': portfolio.map((item) => item.toJson()).toList(),
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  static User fromJson(Map<String, dynamic> json, String id) => User(
        id: id,
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        password: json['password'] ?? '',
        balance: (json['balance'] ?? 0).toDouble(),
        portfolio: (json['portfolio'] as List<dynamic>?)
                ?.map((item) => PortfolioItem.fromJson(item))
                .toList() ??
            [],
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null,
      );
}
