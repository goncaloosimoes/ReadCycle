import 'package:flutter/material.dart';

class ChatDetailScreen extends StatefulWidget {
  final String chatName;

  const ChatDetailScreen({super.key, required this.chatName});

  @override
  State<StatefulWidget> createState() => _MainState();
}
class _MainState extends State<ChatDetailScreen> {

  bool _tradeMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/blank_profile.jpg',
              ),
              radius: 16,
            ),
            SizedBox(width: 8),
            Text(widget.chatName),
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
                        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage('assets/images/blank_profile.jpg'),
                                    radius: 16,
                                  ),
                                  // Por aqui os meus livros
                                ],
                              ),
                              VerticalDivider(
                                width: 100,
                                thickness: 5,
                                indent: 20,
                                endIndent: 20,
                                color: Colors.red,
                              ),
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage('assets/images/blank_profile.jpg'),
                                    radius: 16,
                                    // Por aqui os livros da outra pessoa
                                  )
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Por aqui os botões de adicionar e aceitar
                              TextButton(
                                onPressed: () {
                                  // Por função de adicionar
                                },
                                child: Text("Adicionar livros"),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Por função de aceitar troca
                                },
                                child: Text("Aceitar troca"),
                              )
                            ],
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
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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
