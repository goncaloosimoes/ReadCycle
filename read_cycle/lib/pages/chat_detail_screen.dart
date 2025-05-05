import 'package:flutter/material.dart';
import 'package:read_cycle/classes/user.dart';
import 'package:read_cycle/components/book_small_tile.dart';
import 'package:read_cycle/data/fiction_books.dart';
import 'package:read_cycle/data/users.dart';

class ChatDetailScreen extends StatefulWidget {
  final User chatUser;

  const ChatDetailScreen({super.key, required this.chatUser});

  @override
  State<StatefulWidget> createState() => _MainState();
}
class _MainState extends State<ChatDetailScreen> {

  bool _tradeMenuOpen = false;

  List<Widget> myBooks = [
    // Adicionar livros
  ];

  //List<Widget> myBooks = [
  //  SizedBox(
  //    width: 20,
  //    height: 30,
  //    child: ColoredBox(color: Colors.blue),
  //  )
  //];

  List<Widget> otherBooks = [
    BookSmallTile(book: appFictionBooks[3]),
    BookSmallTile(book: appFictionBooks[2]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                widget.chatUser.profileImagePath
              ),
              radius: 16,
            ),
            SizedBox(width: 8),
            Text(widget.chatUser.name),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size(200, 30),
          child: SizedBox(
            width: 200,
            height: 30,
            child: TextButton(
              onPressed: () {
                // Abrir menu
                setState(() {
                  _tradeMenuOpen = !_tradeMenuOpen;
                });
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith((states) {
                  Color color = Color.fromARGB(255, 246, 237, 218);
                  if (states.contains(WidgetState.pressed)) {
                    return color.withAlpha(220);
                  } else if (states.contains(WidgetState.hovered)) {
                    return color.withValues(alpha: 0.85);
                  } else if (states.contains(WidgetState.disabled)) {
                    return color.withValues(alpha: 0.4);
                  }
                  return color; // Default color
                }),

              ),
              child: const Icon(
                Icons.arrow_drop_down,
              ),
            ),
          ),
        ),
      ),

            
      body: Stack(
        children: [

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ListView(
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
                          style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ),
                    // Adicione mais mensagens conforme necessário
                  ],
                ),
              ),
            ],
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedSize(
              duration: Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              child: _tradeMenuOpen
                  ? Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
                    child: Container(
                      height: 400,
                      color: Color.fromARGB(255, 246, 237, 218),
                      child: Padding(
                        padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                        child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(currentUser.profileImagePath),
                                      radius: 16,
                                    )
                                  ),
                                  SizedBox(
                                    width: 120,
                                    height: 250,
                                    child: ListView.builder(
                                      itemCount: myBooks.length,
                                      itemBuilder: (context, index) => Padding(
                                        padding: EdgeInsets.only(bottom: 15),
                                        child: myBooks[index],
                                        ),
                                    )
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 280,
                                child: VerticalDivider(
                                  width: 10,
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(widget.chatUser.profileImagePath),
                                      radius: 16,
                                    )
                                  ),
                                  SizedBox(
                                    width: 120,
                                    height: 250,
                                    child: ListView.builder(
                                      itemCount: otherBooks.length,
                                      itemBuilder: (context, index) => Padding(
                                        padding: EdgeInsets.only(bottom: 15),
                                        child: otherBooks[index],
                                        ),
                                  )
                                  )
                                  
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            height: 20,
                            color: Color.fromARGB(0, 0, 0, 0),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Por aqui os botões de adicionar e aceitar
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(255, 221, 212, 192),
                                      minimumSize: Size(150, 50),
                                    ),
                                    onPressed: () {
                                      // Por função de adicionar
                                    },
                                    child: Text("Adicionar livros"),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.green.shade200,
                                      minimumSize: Size(150, 50),
                                    ),
                                    onPressed: () {
                                      // Por função de aceitar troca
                                    },
                                    child: Text("Aceitar troca"),
                                  )
                                ],
                              )
                            )
                          )
                        ],
                      )),
                    ),
                  )
                  : SizedBox.shrink(),
            ),
          )
        ],
      ),
      
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: MediaQuery.of(context).viewInsets.bottom + 30),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Escreva uma mensagem...',
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

