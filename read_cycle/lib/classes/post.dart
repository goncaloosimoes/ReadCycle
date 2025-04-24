import 'package:read_cycle/classes/book.dart';
import 'package:read_cycle/classes/user.dart';

class Post {
  User user;
  Book book;
  String location;
  DateTime date;
  List<String> imagePaths;
  String notes;

  Post({
    required this.user,
    required this.book,
    required this.location,
    required this.date,
    required this.imagePaths,
    required this.notes,
  });

  String get postNotes => notes;
  User get postUser => user;
  Book get postBook => book;
  List<String> get postImages => imagePaths;
}