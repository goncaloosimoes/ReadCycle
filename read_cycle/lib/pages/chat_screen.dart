import 'package:flutter/material.dart';
import 'package:read_cycle/data/users.dart';
import 'chat_detail_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> chats = [
      {'user': appUsers[0], 'lastMessage': 'Última mensagem...', 'read': false},
      {'user': appUsers[1], 'lastMessage': 'Última mensagem...', 'read': true},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Mensagens'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Ação ao clicar no ícone de pesquisa
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Ação ao clicar no ícone de mais opções
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListView.separated(
          itemCount: chats.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(
                    chats[index]['user'].profileImagePath,
                  ),
                  radius: 25,
                ),
                title: Text(
                  chats[index]['user'].name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Aumentar o tamanho da fonte
                  ),
                ),
                subtitle: Text(
                  chats[index]['lastMessage'],
                  style: TextStyle(
                    fontWeight:
                        chats[index]['read']
                            ? FontWeight.normal
                            : FontWeight.w900,
                  ),
                ),
                trailing: Icon(
                  Icons.message,
                  color: Theme.of(context).primaryColor,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              ChatDetailScreen(chatUser: chats[index]['user']),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
