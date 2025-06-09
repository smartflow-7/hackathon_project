/// Returns a human-readable relative time string from a given DateTime
/// Examples: "2 hours ago", "3 days ago", "1 year ago", "just now"
String getRelativeTime(DateTime date) {
  final now = DateTime.now().toUtc();
  final utcDate = date.isUtc ? date : date.toUtc();
  final difference = now.difference(utcDate);

  if (difference.inDays > 365) {
    final years = (difference.inDays / 365).floor();
    return years == 1 ? '1 year ago' : '$years years ago';
  } else if (difference.inDays > 30) {
    final months = (difference.inDays / 30).floor();
    return months == 1 ? '1 month ago' : '$months months ago';
  } else if (difference.inDays > 0) {
    final days = difference.inDays;
    return days == 1 ? '1 day ago' : '$days days ago';
  } else if (difference.inHours > 0) {
    final hours = difference.inHours;
    return hours == 1 ? '1 hour ago' : '$hours hours ago';
  } else if (difference.inMinutes > 0) {
    final minutes = difference.inMinutes;
    return minutes == 1 ? '1 minute ago' : '$minutes minutes ago';
  } else {
    return 'just now';
  }
}

/// Convenience function to get relative time from Unix timestamp
/// [timestamp] - Unix timestamp in seconds
String getRelativeTimetimestamp(int timestamp) {
  final date =
      DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
  return getRelativeTime(date);
}
