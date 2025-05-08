import 'package:read_cycle/classes/book.dart';
import 'package:read_cycle/classes/message.dart';
import 'package:read_cycle/classes/user.dart';

class Chat {
  User user;
  bool read;
  List<Book> myBooks;
  List<Book> otherBooks;
  List<Message> messages;
  Message get lastMessage => messages.last;
  bool ready = false;
  bool otherReady = false;

  Chat({
    required this.user,
    this.read = false,
    required this.myBooks,
    required this.otherBooks,
    required this.messages,
  });
}