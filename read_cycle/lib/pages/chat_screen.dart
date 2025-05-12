import 'package:flutter/material.dart';
import 'package:read_cycle/data/chats.dart';
import 'package:read_cycle/main.dart';
import 'chat_detail_screen.dart';
import 'package:read_cycle/classes/chat.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  
  @override
  State<ChatScreen> createState() => _MainState();
}

class _MainState extends State<ChatScreen> {
  late List<Chat> sortedChats;
  
  @override
  void initState() {
    super.initState();
    // Inicializa a lista de chats ordenada
    _sortChats();
  }
  
  void _sortChats() {
    sortedChats = List.from(chats);

    sortedChats.sort((a, b) {
      if (a.user.name == 'Emma') return -1;
      if (b.user.name == 'Emma') return 1;
      return 0;
    });

    sortedChats.sort((a, b) {
      if (a.user.name == 'Emma') return -1;
      if (b.user.name == 'Emma') return 1;

      if (a.messages.isEmpty) return 1;
      if (b.messages.isEmpty) return -1;

      return b.lastMessage.timestamp - a.lastMessage.timestamp;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Mensagens'),
        actions: [
          //IconButton(
          //  icon: Icon(Icons.search),
          //  onPressed: () {
          //    // Ação ao clicar no ícone de pesquisa
          //  },
          //),
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
          itemCount: sortedChats.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: sortedChats[index].user.profileImage.build(),
                  radius: 25,
                ),
                title: Text(
                  sortedChats[index].user.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Aumentar o tamanho da fonte
                  ),
                ),
                subtitle: Text(
                  (sortedChats[index].messages.isNotEmpty) ? sortedChats[index].lastMessage.text : '',
                  style: TextStyle(
                    fontWeight:
                        sortedChats[index].read
                            ? FontWeight.normal
                            : FontWeight.w900,
                  ),
                ),
                trailing: Icon(
                  Icons.message,
                  color: Theme.of(context).primaryColor,
                ),
                onTap: () {
                  setState(() {
                    sortedChats[index].read = true;
                  });
                  mainScreenKey.currentState?.update(); // Atualizar o nº de notificações
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatDetailScreen(chat: sortedChats[index])),
                  ).then((value) {
                    setState(() {
                      // Reordena os chats ao voltar, caso alguma mensagem nova tenha sido adicionada
                      _sortChats();
                    });
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}