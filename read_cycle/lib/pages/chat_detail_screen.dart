import 'package:flutter/material.dart';

class ChatDetailScreen extends StatelessWidget {
  final String chatName;

  const ChatDetailScreen({super.key, required this.chatName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/blank_profile.jpg',
              ), // Substitua pelo caminho do avatar real
              radius: 16,
            ),
            SizedBox(width: 8),
            Text(chatName),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          // Exemplo de mensagens
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('Mensagem recebida', style: TextStyle(fontSize: 16)),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Mensagem enviada',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
          // Adicione mais mensagens conforme necessário
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Digite uma mensagem',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                // Ação ao enviar mensagem
              },
            ),
          ],
        ),
      ),
    );
  }
}
