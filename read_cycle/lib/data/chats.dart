import 'dart:math';

import 'package:read_cycle/classes/book.dart';
import 'package:read_cycle/classes/chat.dart';
import 'package:read_cycle/data/users.dart';

var _random = Random();

int getNumNotifications() {
  int returnVal = 0;
  for (Chat chat in chats) {
    if (!chat.read) {
      returnVal++;
    }
  }
  return returnVal;
}

List<Chat> chats = [
  for (var user in appUsers) Chat(
    user: user,
    myBooks: [],
    otherBooks: [
      if (user.name == "Emma")  // Emma apenas disponibiliza o hobbit
        user.books.firstWhere((book) => book.title.toLowerCase().contains("hobbit"))
      else
        for (Book book in user.books) if (_random.nextBool()) book
      ],
      messages: [],
      read: true,
    ),
];