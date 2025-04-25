import 'package:read_cycle/classes/book.dart';

class User {
  String name;
  String email;
  String location;
  String profileImagePath;
  String rating;
  List<String> favGenres;
  String bio;
  List<Book> books;
  int numTrades;

  User({
    required this.name,
    required this.email,
    required this.location,
    required this.profileImagePath,
    required this.rating,
    required this.favGenres,
    required this.bio,
    required this.books,
    required this.numTrades
  }); 
}