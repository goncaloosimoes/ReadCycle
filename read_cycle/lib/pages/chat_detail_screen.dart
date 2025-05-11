import 'package:flutter/material.dart';
import 'package:read_cycle/classes/book.dart';
import 'package:read_cycle/classes/chat.dart';
import 'package:read_cycle/classes/message.dart';
import 'package:read_cycle/components/book_small_button.dart';
import 'package:read_cycle/components/book_small_tile.dart';
import 'package:read_cycle/components/message_widget.dart';
import 'package:read_cycle/data/users.dart';
import 'package:read_cycle/pages/others_profile_screen.dart';

class ChatDetailScreen extends StatefulWidget {
  final Chat chat;

  const ChatDetailScreen({super.key, required this.chat});

  @override
  State<StatefulWidget> createState() => _MainState();
}
class _MainState extends State<ChatDetailScreen> {

  bool _tradeMenuOpen = false;
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showHelpText = true;
  
  @override
  void initState() {
    super.initState();
    booksToAdd.addAll(widget.chat.myBooks);
    booksToAddBackup.addAll(booksToAdd);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  // Livros que vão ser adicionados
  List<Book> booksToAdd = [];
  List<Book> booksToAddBackup = [];

  void scrollChat() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void sendMessage() {
    if (_textController.text.isEmpty) {
      return;
    }

    setState(() {
      widget.chat.messages.add(Message(text: _textController.text, fromUser: true));
      _showHelpText = false; // Hide help text after sending the first message
    });
    _textController.clear();
    scrollChat();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OthersProfileScreen(user: widget.chat.user),
              ),
            );
          },
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: widget.chat.user.profileImage.build(),
                radius: 16,
              ),
              SizedBox(width: 8),
              Text(widget.chat.user.name),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(200, 30),
          child: SizedBox(
            width: 200,
            height: 30,
            child: TextButton(
              onPressed: () {
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
                child: Stack(
                  children: [
                    ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.all(16.0),
                      itemCount: widget.chat.messages.length,
                      itemBuilder: (context, index) {
                        return MessageWidget(message: widget.chat.messages[index]);
                      },
                    ),
                    if (_showHelpText) // desaparece se for enviada uma mensagem
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 80.0),
                          child: Text(
                            "Seleciona livros para trocar usando o menu acima. \nPara a data, hora, e local indica-os no chat!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedSlide(
              offset: _tradeMenuOpen ? Offset(0, 0) : Offset(0, -1),
              duration: Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              child: AnimatedOpacity(
                opacity: _tradeMenuOpen ? 1 : 0,
                duration: Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                child: Padding(
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
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: currentUser.profileImage.build(),
                                        radius: 16,
                                      ),
                                      SizedBox(width: 8),
                                      Text((widget.chat.ready)?"✅ pronto!":""),
                                    ],
                                  )
                                ),
                                SizedBox(
                                  width: 120,
                                  height: 250,
                                  child: ListView.builder(
                                    itemCount: widget.chat.myBooks.length,
                                    itemBuilder: (context, index) => Padding(
                                      padding: EdgeInsets.only(bottom: 15),
                                      child: BookSmallTile(key: UniqueKey(), book: widget.chat.myBooks[index]),
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
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: widget.chat.user.profileImage.build(),
                                        radius: 16,
                                      ),
                                      SizedBox(width: 8),
                                      Text((widget.chat.otherReady)?"✅ pronto!":""),
                                    ],
                                  )
                                ),
                                SizedBox(
                                  width: 120,
                                  height: 250,
                                  child: ListView.builder(
                                    itemCount: widget.chat.otherBooks.length,
                                    itemBuilder: (context, index) => Padding(
                                      padding: EdgeInsets.only(bottom: 15),
                                      child: BookSmallTile(book: widget.chat.otherBooks[index]),
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
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 221, 212, 192),
                                    minimumSize: Size(120, 50),
                                  ),
                                  onPressed: () {
                                    List<Widget> bookWidgets = List.generate(currentUser.books.length, (index) {
                                      return BookSmallButton(
                                        book: currentUser.books[index],
                                        selected: booksToAdd.contains(currentUser.books[index]),
                                        onSelectChange: (selected) {
                                          if (selected) {
                                            booksToAdd.add(currentUser.books[index]);
                                          } else {
                                            booksToAdd.remove(currentUser.books[index]);
                                          }
                                        },
                                      );
                                    });
                                    booksToAddBackup.clear();
                                    booksToAddBackup.addAll(booksToAdd);
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: (context, setStateDialog) {
                                            AlertDialog dialog = AlertDialog(
                                              title: const Text("Adicionar livros"),
                                              content: SizedBox(
                                                width: double.maxFinite,
                                                height: 500,
                                                child: GridView.count(
                                                  // crossAxisCount is the number of columns
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 12,
                                                  // This creates two columns with two items in each column
                                                  children: bookWidgets
                                                )
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      widget.chat.myBooks.clear();
                                                      widget.chat.myBooks.addAll(booksToAddBackup);
                                                      booksToAdd.clear(); booksToAdd.addAll(booksToAddBackup);
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Cancelar'),
                                                ),
                                                ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor: WidgetStateProperty.all(Colors.green.shade200),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      widget.chat.myBooks.clear();
                                                      widget.chat.myBooks.addAll(booksToAdd);
                                                      widget.chat.ready = false;
                                                      widget.chat.otherReady = false;
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Guardar'),
                                                ),
                                              ],
                                            );
                                            return dialog;
                                          }
                                        );
                                      }
                                    );
                                    setState(() {});
                                    booksToAdd.clear();
                                  },
                                  child: Text("Adicionar livros"),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: (!widget.chat.ready)?Colors.green.shade200:Colors.red.shade200,
                                    minimumSize: Size(120, 50),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      widget.chat.ready = !widget.chat.ready;
                                      if (widget.chat.ready && widget.chat.otherReady) {
                                        // TODO: fazer aqui o 'troca a decorrer'
                                      }
                                    });
                                  },
                                  child: Text((!widget.chat.ready)?"Aceitar troca":"Rejeitar troca"),
                                )
                              ],
                            )
                          )
                        )
                      ],
                    )),
                  ),
                )
              )
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
                controller: _textController,
                decoration: InputDecoration(
                  hintText: 'Escreva uma mensagem...',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  sendMessage();
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                sendMessage();
              },
            ),
          ],
        ), 
      ),
    );
  }
}