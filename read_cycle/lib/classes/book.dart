import 'package:read_cycle/classes/app_image.dart';

class Book {
  String title;
  String author;
  int pages;
  List<String> genres;
  AppImage coverImage;
  String description;
  String isbn;

  Book({
    required this.title,
    required this.author,
    required this.pages,
    required this.genres,
    required this.coverImage,
    required this.description,
    this.isbn = ""
  });

}
