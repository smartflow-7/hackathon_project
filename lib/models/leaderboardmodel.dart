class LeaderboardUser {
  final String id;
  final String name;
  final double totalBalance;

  LeaderboardUser({
    required this.id,
    required this.name,
    required this.totalBalance,
  });

  factory LeaderboardUser.fromJson(Map<String, dynamic> json) {
    return LeaderboardUser(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      totalBalance: (json['totalBalance'] ?? 0).toDouble(),
    );
  }
}

class LeaderboardResponse {
  final bool success;
  final String message;
  final List<LeaderboardUser> leaderboard;

  LeaderboardResponse({
    required this.success,
    required this.message,
    required this.leaderboard,
  });

  factory LeaderboardResponse.fromJson(Map<String, dynamic> json) {
    return LeaderboardResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      leaderboard: (json['leaderboard'] as List<dynamic>?)
              ?.map((user) => LeaderboardUser.fromJson(user))
              .toList() ??
          [],
    );
  }
}
