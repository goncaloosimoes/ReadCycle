import 'package:read_cycle/classes/chat.dart';
import 'package:read_cycle/data/users.dart';

List<Chat> chats = [
  for (var user in appUsers) Chat(user: user, myBooks: [], otherBooks: [], messages: [], read: false),
];