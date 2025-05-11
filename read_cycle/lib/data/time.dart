import 'package:read_cycle/classes/post.dart';

DateTime appStartTime = DateTime.now();

String calculateDays(Post post) {
  final postDate = post.date;
  final difference = appStartTime.difference(postDate).inDays;
  if (difference == 0) return 'Hoje';  
  if (difference == 1) return 'Há 1 dia';
  return 'Há $difference dias';
}

DateTime xDaysAgo(int days) {
  return DateTime.now().subtract(Duration(days: days));
}
