import 'package:flutter/material.dart';
import 'package:read_cycle/bar_stuff.dart';
import 'package:read_cycle/classes/book.dart';
import 'package:read_cycle/classes/chat.dart';
import 'package:read_cycle/classes/message.dart';
import 'package:read_cycle/components/book_small_button.dart';
import 'package:read_cycle/components/book_small_tile.dart';
import 'package:read_cycle/components/message_widget.dart';
import 'package:read_cycle/data/users.dart';
import 'package:read_cycle/pages/others_profile_screen.dart';
import 'dart:async';

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

  Timer? _replyTimer;
  Timer? _typingTimer;
  bool _emmaReplied = false;

  @override
  void initState() {
    super.initState();
    booksToAdd.addAll(widget.chat.myBooks);
    booksToAddBackup.addAll(booksToAdd);
    _textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (_tradeMenuOpen && _textController.text.isNotEmpty) {
      setState(() {
        _tradeMenuOpen = false;
      });
    }
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
    if (_textController.text.isEmpty) return;

    setState(() {
      widget.chat.messages.add(
        Message(text: _textController.text, fromUser: true),
      );
      _showHelpText = false;
      _emmaReplied = false;
    });

    _textController.clear();
    scrollChat();
  }

  void _scheduleEmmaFollowUp({String message = "Está combinado. Até já!"}) {
    _replyTimer?.cancel();

    _replyTimer = Timer(Duration(seconds: 6), () {
      if (!_emmaReplied && mounted) {
        setState(() {
          widget.chat.messages.add(Message(text: message, fromUser: false));
          _emmaReplied = true;
        });
        scrollChat();
      }
    });
  }

  void _startTypingTimeout() {
    _typingTimer?.cancel();

    _typingTimer = Timer(Duration(seconds: 4), () {
      if (mounted && _textController.text.isEmpty) {
        _scheduleEmmaFollowUp();
      }
    });
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
                builder:
                    (context) => OthersProfileScreen(user: widget.chat.user),
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
          preferredSize: Size(200, 40),
          child: SizedBox(
            width: 200,
            height: 40,
            child: TextButton(
              onPressed: () {
                setState(() {
                  _tradeMenuOpen = !_tradeMenuOpen;
                });
                FocusScope.of(context).unfocus();
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Color.fromARGB(255, 232, 205, 149),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Livros para trocar"),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _tradeMenuOpen = false;
          });
          FocusScope.of(context).unfocus();
        },
        child: Stack(
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
                          return MessageWidget(
                            message: widget.chat.messages[index],
                          );
                        },
                      ),
                      if (_showHelpText) // desaparece se for enviada uma mensagem
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 80.0),
                            child: Text(
                              "Seleciona livros para trocar usando o menu acima. \nPara outras informações, podes usar o chat!",
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

            // Menu de selecionar livros
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
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage:
                                                    currentUser.profileImage
                                                        .build(),
                                                radius: 16,
                                              ),
                                              if (widget.chat.ready)
                                                SizedBox(width: 8),
                                              Text(
                                                (widget.chat.ready)
                                                    ? "✅ pronto!"
                                                    : "",
                                              ),
                                            ],
                                          ),
                                          Text(currentUser.name),
                                        ],
                                      )
                                    ),
                                    SizedBox(
                                      width: 120,
                                      height: 250,
                                      child: ListView.builder(
                                        itemCount: widget.chat.myBooks.length,
                                        itemBuilder:
                                            (context, index) => Padding(
                                              padding: EdgeInsets.only(
                                                bottom: 15,
                                              ),
                                              child: BookSmallTile(
                                                key: UniqueKey(),
                                                book:
                                                    widget.chat.myBooks[index],
                                              ),
                                            ),
                                      ),
                                    ),
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
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage:
                                                    widget.chat.user.profileImage
                                                        .build(),
                                                radius: 16,
                                              ),
                                              if (widget.chat.otherReady)
                                                SizedBox(width: 8),
                                              Text(
                                                (widget.chat.otherReady)
                                                    ? "✅ pronto!"
                                                    : "",
                                              ),
                                            ],
                                          ),
                                          Text(widget.chat.user.name),
                                        ],
                                      )
                                    ),
                                    SizedBox(
                                      width: 120,
                                      height: 250,
                                      child: ListView.builder(
                                        itemCount:
                                            widget.chat.otherBooks.length,
                                        itemBuilder:
                                            (context, index) => Padding(
                                              padding: EdgeInsets.only(
                                                bottom: 15,
                                              ),
                                              child: BookSmallTile(
                                                book:
                                                    widget
                                                        .chat
                                                        .otherBooks[index],
                                              ),
                                            ),
                                      ),
                                    ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                          255,
                                          221,
                                          212,
                                          192,
                                        ),
                                        minimumSize: Size(120, 50),
                                      ),
                                      onPressed: () {
                                        List<Widget>
                                        bookWidgets = List.generate(
                                          currentUser.books.length,
                                          (index) {
                                            return BookSmallButton(
                                              book: currentUser.books[index],
                                              selected: booksToAdd.contains(
                                                currentUser.books[index],
                                              ),
                                              onSelectChange: (selected) {
                                                if (selected) {
                                                  booksToAdd.add(
                                                    currentUser.books[index],
                                                  );
                                                } else {
                                                  booksToAdd.remove(
                                                    currentUser.books[index],
                                                  );
                                                }
                                              },
                                            );
                                          },
                                        );
                                        booksToAddBackup.clear();
                                        booksToAddBackup.addAll(booksToAdd);
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return StatefulBuilder(
                                              builder: (
                                                context,
                                                setStateDialog,
                                              ) {
                                                AlertDialog
                                                dialog = AlertDialog(
                                                  title: const Text(
                                                    "Adicionar livros",
                                                  ),
                                                  content: SizedBox(
                                                    width: double.maxFinite,
                                                    height: 500,
                                                    child: GridView.count(
                                                      // crossAxisCount is the number of columns
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 12,
                                                      // This creates two columns with two items in each column
                                                      children: bookWidgets,
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          widget.chat.myBooks.clear();
                                                          widget.chat.myBooks.addAll(booksToAddBackup);
                                                          booksToAdd.clear();
                                                          booksToAdd.addAll(booksToAddBackup);
                                                        });
                                                        Navigator.of(context).pop();
                                                        FocusScope.of(context).unfocus();
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
                                                        FocusScope.of(context).unfocus();
                                                      },
                                                      child: const Text('Guardar'),
                                                    ),
                                                  ],
                                                );
                                                return dialog;
                                              },
                                            );
                                          },
                                        );
                                        setState(() {});
                                        booksToAdd.clear();
                                      },
                                      child: Text("Adicionar livros"),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor:
                                            (!widget.chat.ready)
                                                ? Colors.green.shade400
                                                : Colors.red.shade300,
                                        minimumSize: Size(120, 50),
                                      ),
                                      onPressed: () {
                                        bool newReady = !widget.chat.ready;

                                        setState(() {
                                          widget.chat.ready = newReady;
                                        });

                                        _scheduleEmmaFollowUp(
                                          message:
                                              "Olá, esse livro parece-me muito interessante! Acho que vou querer lê-lo",
                                        );

                                        // Simulate Emma confirming after 3 seconds
                                        if (newReady) {
                                          Timer(Duration(seconds: 2), () {
                                            if (!mounted) return;
                                            setState(() {
                                              widget.chat.otherReady = true;
                                            });
                                          });
                                        } else {
                                          // If user unchecks readiness, Emma "unconfirms" too
                                          setState(() {
                                            widget.chat.otherReady = false;
                                          });
                                        }
                                      },
                                      child: Text(
                                        (!widget.chat.ready)
                                            ? "Propor troca"
                                            : "Rejeitar troca", // TODO: trocar 
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: 'Escreva uma mensagem...',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (_) {
                          _startTypingTimeout();
                        },
                        onTap: () {
                          setState(() {
                            _tradeMenuOpen = false;
                          });
                        },
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
            ),
          ],
        ),
      ),

      bottomNavigationBar: Column(
        verticalDirection: VerticalDirection.up,
        mainAxisSize: MainAxisSize.min,
        children: [
          MainBar(),
          

        ]
      )
    );
  }
}
