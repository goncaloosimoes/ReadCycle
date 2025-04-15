import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> chats = ['Chat 1', 'Chat 2', 'Chat 3'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Chats Disponíveis'),
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
                  backgroundImage: AssetImage('assets/images/blank_profile.jpg'),
                  radius: 25,
                ),
                title: Text(
                  chats[index],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Aumentar o tamanho da fonte
                  ),
                ),
                subtitle: Text('Última mensagem...'),
                trailing: Icon(
                  Icons.message,
                  color: Theme.of(context).primaryColor,
                ),
                onTap: () {
                  // Ação ao clicar no chat
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
