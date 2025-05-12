class Message {
  bool fromUser; // True if from the current user
  String text;
  int timestamp;

  // Construtor com timestamp automático
  Message({
    required this.text, 
    required this.fromUser, 
    int? timestamp // Parâmetro opcional
  }) : timestamp = timestamp ?? DateTime.now().millisecondsSinceEpoch;
  
  static Message now({required String text, required bool fromUser}) {
    return Message(
      text: text,
      fromUser: fromUser,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }

  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(timestamp);
  
  String get formattedTime {
    final date = dateTime;
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}