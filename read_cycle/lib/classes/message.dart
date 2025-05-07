class Message {
  bool fromUser; // True if from the current user
  String text;

  Message({
    required this.text,
    required this.fromUser,
  });
}