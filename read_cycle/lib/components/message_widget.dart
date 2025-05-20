import 'package:flutter/material.dart';
import 'package:read_cycle/classes/message.dart';

class MessageWidget extends StatelessWidget {
  final Message message;

  const MessageWidget({super.key, required this.message});
  
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: (message.fromUser) ? Alignment.centerRight : Alignment.centerLeft,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: (message.fromUser) ? Theme.of(context).primaryColorLight : Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
                  message.text,
                  style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 0, 0, 0)),
                ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Text(
              message.formattedTime,
              style: TextStyle(
                fontSize: 11,
              )
            )
          )
        ],
      )
    );
  }
}