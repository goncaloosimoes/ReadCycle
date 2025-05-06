class Book {
  String title;
  String author;
  int pages;
  List<String> genres;
  String coverImagePath;
  String description;
  String isbn;

  Book({
    required this.title,
    required this.author,
    required this.pages,
    required this.genres,
    required this.coverImagePath,
    required this.description,
    this.isbn = ""
  });

}
