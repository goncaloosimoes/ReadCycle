import 'package:flutter/material.dart';
import 'package:read_cycle/bar_stuff.dart';
import 'package:read_cycle/classes/post.dart';
import 'package:read_cycle/classes/sort_mode.dart';
import 'package:read_cycle/components/search_result.dart';
import 'package:read_cycle/components/wishlist.dart';
import 'package:read_cycle/data/posts.dart';
import 'package:read_cycle/data/users.dart';
import 'package:read_cycle/main_screen.dart';

class SearchScreen extends StatefulWidget {
  final String searchText;
  const SearchScreen(this.searchText, {super.key});

  @override
  State<SearchScreen> createState() => _MainState();
}

final GlobalKey<MainScreenState> mainScreenKey = GlobalKey();

class _MainState extends State<SearchScreen> {
  String searchText = "";
  bool addedToWishlist = false;
  final TextEditingController _controller = TextEditingController();
  List<SearchResult> searchResults = [];
  SortMode sortMode = SortMode.classification;

  _MainState();

  void reloadPage() {
    if (_controller.text.trim() == '') {
      return;
    }
    setState(() {
      addedToWishlist = false;
      searchText = _controller.text.trim();
      getRelevantPosts();
    });
  }

  void getRelevantPosts() {
    searchResults = [];

    // Listar posts relevantes
    for (Post post in allPosts) {
      if (searchText.toLowerCase().contains(post.book.title.toLowerCase())) {
        searchResults.add(SearchResult(post: post));
      } else if (post.book.title.toLowerCase().contains(
        searchText.toLowerCase(),
      )) {
        searchResults.add(SearchResult(post: post));
      }
    }

    // ordenar
    if (sortMode == SortMode.classification) {
      searchResults.sort(
        (a, b) => b.post.user.rating.compareTo(a.post.user.rating),
      );
    } else if (sortMode == SortMode.recent) {
      searchResults.sort((a, b) => b.post.date.compareTo(a.post.date));
    }
  }

  @override
  void initState() {
    super.initState();

    // Definir valores iniciais
    _controller.text = widget.searchText.trim();
    searchText = widget.searchText.trim();
    addedToWishlist = currentUser.wishlist.contains(widget.searchText.trim());

    getRelevantPosts();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          elevation: 0,
          actions: [
            IconButton(onPressed: reloadPage, icon: const Icon(Icons.search)),
            PopupMenuButton<SortMode>(
              icon: Icon(Icons.sort),
              onSelected: (SortMode selectedMode) {
                setState(() {
                  sortMode = selectedMode;
                  getRelevantPosts();
                });
              },
              itemBuilder:
                  (BuildContext context) => <PopupMenuEntry<SortMode>>[
                    PopupMenuItem<SortMode>(
                      value: SortMode.classification,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Ordenar por classificação'),
                          if (sortMode == SortMode.classification)
                            Icon(Icons.check, size: 18, color: Colors.black),
                        ],
                      ),
                    ),
                    PopupMenuItem<SortMode>(
                      value: SortMode.recent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Ordenar por mais recentes'),
                          if (sortMode == SortMode.recent)
                            Icon(Icons.check, size: 18, color: Colors.black),
                        ],
                      ),
                    ),
                  ],
            ),
          ],
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 220,
                    height: 50,
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (value) {
                        reloadPage();
                      },
                      onChanged: (value) {
                        reloadPage();
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Color.fromARGB(255, 241, 241, 241),
                        filled: true,
                        hintText: 'Pesquisa um livro...',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,

          itemCount: (searchResults.isEmpty) ? 2 : searchResults.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Text(
                  "${searchResults.length} Resultados para \"$searchText\"",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            // Quando não há resultados, mostrar opção da lista de desejos
            if (searchResults.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => WishList(
                            bookName: searchText,
                            afterSave: () {
                              setState(() {
                                addedToWishlist = true;
                              });
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  Future.delayed(
                                    const Duration(seconds: 2),
                                    () {
                                      Navigator.of(context).pop();

                                      selectedIdx = 0;
                                      mainScreenKey.currentState?.update();
                                    },
                                  );

                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    title: Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            'Livro adicionado à lista de desejos!',
                                            style: TextStyle(fontSize: 18),
                                            softWrap: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          addedToWishlist
                              ? Color.fromARGB(255, 240, 249, 255)
                              : Color.fromARGB(255, 245, 245, 245),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color:
                            addedToWishlist
                                ? Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.5)
                                : Colors.grey.withOpacity(0.3),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              addedToWishlist
                                  ? Theme.of(
                                    context,
                                  ).colorScheme.primary.withOpacity(0.15)
                                  : Colors.grey.withOpacity(0.1),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            (addedToWishlist)
                                ? "\"$searchText\" adicionado à lista de desejos!"
                                : "Adicionar \"$searchText\" à lista de desejos?",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  addedToWishlist
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                              color:
                                  addedToWishlist
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.black87,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color:
                                addedToWishlist
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.secondary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    addedToWishlist
                                        ? Theme.of(
                                          context,
                                        ).colorScheme.primary.withOpacity(0.3)
                                        : Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withOpacity(0.3),
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            addedToWishlist
                                ? Icons.bookmark
                                : Icons.bookmark_add_outlined,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            // Retornar resultados normais
            return Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: searchResults[index - 1],
            );
          },
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: isKeyboardOpen ? null : const CreatePostButton(),
      bottomNavigationBar: MainBar(),
    );
  }
}
