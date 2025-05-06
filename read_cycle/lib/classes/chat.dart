import 'package:read_cycle/classes/book.dart';
import 'package:read_cycle/classes/user.dart';

class Chat {
  User user;
  List<Book> myBooks;
  List<Book> otherBooks;

  Chat({
    required this.user,
    required this.myBooks,
    required this.otherBooks,
  });
}