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

  String get bookTitle => book.title;
  String get bookImage => book.coverImagePath;
  String get bookAuthor => book.author;
  int get bookPages => book.pages;
  List<String> get bookGenres => book.genres;
  String get bookDescription => book.description;
  String get postNotes => notes;
  String get userName => user.name;
  String get userRating => user.rating;
  String get userProfileImage => user.profileImagePath;
}