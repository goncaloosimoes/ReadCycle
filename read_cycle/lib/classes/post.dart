import 'package:read_cycle/classes/app_image.dart';
import 'package:read_cycle/classes/book.dart';
import 'package:read_cycle/classes/user.dart';

class Post {
  User user;
  Book book;
  String location;
  DateTime date;
  List<AppImage> images;
  String notes;

  Post({
    required this.user,
    required this.book,
    required this.location,
    required this.date,
    required this.images,
    required this.notes,
  });

  String get postNotes => notes;
  User get postUser => user;
  Book get postBook => book;
  List<AppImage> get postImages => images;
}