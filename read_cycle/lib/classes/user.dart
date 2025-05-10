import 'package:read_cycle/classes/app_image.dart';
import 'package:read_cycle/classes/book.dart';

class User {
  String name;
  String email;
  String location;
  AppImage profileImage;
  String rating;
  List<String> favGenres;
  String bio;
  List<Book> books;
  int numTrades;

  User({
    required this.name,
    required this.email,
    required this.location,
    required this.profileImage,
    required this.rating,
    required this.favGenres,
    required this.bio,
    required this.books,
    required this.numTrades
  }); 
}