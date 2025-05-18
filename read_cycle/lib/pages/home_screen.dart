import 'package:flutter/material.dart';
import 'package:read_cycle/components/books_tile.dart';
import 'package:read_cycle/components/post_tile.dart';
import 'package:read_cycle/pages/profile_screen.dart';
import 'package:read_cycle/data/posts.dart';
import 'package:read_cycle/data/users.dart';
import 'package:read_cycle/pages/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MainState();
}

class _MainState extends State<HomeScreen> {
  bool searchBarVisible = false;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<String> bookSuggestions = [];
  bool showSuggestions = false;

  List<String> get allBooks {
    List<String> books = [];

    try {
      if (fictionTiles.isNotEmpty) {
        books.addAll(
          fictionTiles
              .map((tile) => tile.post.book.title)
              .where((title) => title.isNotEmpty),
        );
      }
      if (romanceTiles.isNotEmpty) {
        books.addAll(
          romanceTiles
              .map((tile) => tile.post.book.title)
              .where((title) => title.isNotEmpty),
        );
      }
      if (thrillerTiles.isNotEmpty) {
        books.addAll(
          thrillerTiles
              .map((tile) => tile.post.book.title)
              .where((title) => title.isNotEmpty),
        );
      }
      if (poetryTiles.isNotEmpty) {
        books.addAll(
          poetryTiles
              .map((tile) => tile.post.book.title)
              .where((title) => title.isNotEmpty),
        );
      }
    } catch (e) {
      print('Erro ao obter livros: $e');
    }

    final uniqueBooks = books.toSet().toList()..sort();
    uniqueBooks.add("O Hobbit");
    print('Total de livros únicos: ${uniqueBooks.length}');
    print('Livros: $uniqueBooks');
    return uniqueBooks;
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
    _focusNode.addListener(() {
      setState(() {
        showSuggestions =
            _focusNode.hasFocus &&
            searchBarVisible &&
            bookSuggestions.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _controller.text.toLowerCase().trim();

    if (query.isEmpty) {
      setState(() {
        bookSuggestions = [];
        showSuggestions = false;
      });
      return;
    }

    final suggestions = <String>[];

    for (String book in allBooks) {
      final bookLower = book.toLowerCase();
      final bookNormalized = _normalizeString(bookLower);
      final queryNormalized = _normalizeString(query);

      bool matches = false;

      // 1. Busca direta (contém)
      if (bookLower.contains(query)) {
        matches = true;
      }
      // 2. Busca normalizada (sem acentos/artigos)
      else if (bookNormalized.contains(queryNormalized)) {
        matches = true;
      }
      // 3. Busca por palavras separadas
      else {
        final queryWords = query.split(RegExp(r'\s+'));
        final bookWords = bookLower.split(RegExp(r'\s+'));
        final bookWordsNormalized = bookNormalized.split(RegExp(r'\s+'));

        for (String queryWord in queryWords) {
          if (queryWord.length >= 15) {
            // Pelo menos 15 caracteres na pesquisa (se for mais ele vai parar de acompanhar e destacar
            // as palavras mesmo se derem match com o que está na caixa de pesquisa)
            for (int i = 0; i < bookWords.length; i++) {
              if (bookWords[i].startsWith(queryWord) ||
                  bookWords[i].contains(queryWord) ||
                  bookWordsNormalized[i].startsWith(
                    _normalizeString(queryWord),
                  ) ||
                  bookWordsNormalized[i].contains(
                    _normalizeString(queryWord),
                  )) {
                matches = true;
                break;
              }
            }
            if (matches) break;
          }
        }
      }

      if (matches && !suggestions.contains(book)) {
        suggestions.add(book);
        if (suggestions.length >= 5) break; // Limitar a 5 sugestões
      }
    }

    setState(() {
      bookSuggestions = suggestions;
      showSuggestions =
          suggestions.isNotEmpty && searchBarVisible && _focusNode.hasFocus;
    });
  }

  String _normalizeString(String str) {
    String normalized = str
        .replaceAll(
          RegExp(r'^(the|o|a|os|as|um|uma|uns|umas)\s+', caseSensitive: false),
          '',
        )
        .replaceAll(RegExp(r'[áàâãäå]'), 'a')
        .replaceAll(RegExp(r'[éèêë]'), 'e')
        .replaceAll(RegExp(r'[íìîï]'), 'i')
        .replaceAll(RegExp(r'[óòôõöø]'), 'o')
        .replaceAll(RegExp(r'[úùûü]'), 'u')
        .replaceAll(RegExp(r'[ýÿ]'), 'y')
        .replaceAll(RegExp(r'[ç]'), 'c')
        .replaceAll(RegExp(r'[ñ]'), 'n')
        .replaceAll(RegExp(r'[^\w\s]'), '');

    return normalized;
  }

  void searchButtonFunctionality() {
    if (!searchBarVisible) {
      setState(() {
        searchBarVisible = true;
      });
      Future.delayed(Duration(milliseconds: 200), () {
        _focusNode.requestFocus();
      });
    } else {
      hideSearchBar();
    }
  }

  void _performSearch(String query) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchScreen(query)),
    );
    hideSearchBar();
  }

  void _selectSuggestion(String suggestion) {
    _controller.text = suggestion;
    setState(() {
      showSuggestions = false;
    });
    _focusNode.unfocus();
    _performSearch(suggestion);
  }

  void hideSearchBar() {
    setState(() {
      searchBarVisible = false;
      showSuggestions = false;
    });
    _controller.clear();
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final List<PostTile> suggestionTiles = [
      fictionTiles[2],
      thrillerTiles[0],
      romanceTiles[4],
      thrillerTiles[2],
    ];

    final List<BooksTile> bookTiles = [
      BooksTile(title: 'Sugestões', postTiles: suggestionTiles),
      BooksTile(title: 'Ficção', postTiles: fictionTiles),
      BooksTile(title: 'Romance', postTiles: romanceTiles),
      BooksTile(title: 'Thriller', postTiles: thrillerTiles),
      BooksTile(title: 'Poesia', postTiles: poetryTiles),
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          // It actually popped
        } else {
          // It was canceled or not popped
          hideSearchBar();
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            elevation: 0,
            flexibleSpace: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: Stack(
                          alignment: AlignmentDirectional.centerStart,
                          children: [
                            // Logo ReadCycle
                            Visibility(
                              visible: !searchBarVisible,
                              child: Text(
                                'ReadCycle',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (searchBarVisible)
                              Positioned(
                                left: 0,
                                right: 0,
                                child: TextField(
                                  controller: _controller,
                                  focusNode: _focusNode,
                                  onSubmitted: (value) {
                                    if (value.trim().isNotEmpty) {
                                      _performSearch(value.trim());
                                    }
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    fillColor: Color.fromARGB(
                                      255,
                                      241,
                                      241,
                                      241,
                                    ),
                                    filled: true,
                                    hintText: 'Pesquisar um livro...',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 12,
                                    ),
                                    // Ícone de busca dentro do campo
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.grey[600],
                                    ),
                                    // Botão de limpar quando há texto
                                    suffixIcon:
                                        _controller.text.isNotEmpty
                                            ? IconButton(
                                              icon: Icon(
                                                Icons.clear,
                                                color: Colors.grey[600],
                                              ),
                                              onPressed: () {
                                                _controller.clear();
                                              },
                                            )
                                            : null,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    // Espaçamento entre a barra de pesquisa e os ícones
                    SizedBox(width: 10),
                    // Ícones da direita
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Botão de pesquisa/fechar
                        IconButton(
                          onPressed: searchButtonFunctionality,
                          icon: Icon(
                            searchBarVisible ? Icons.close : Icons.search,
                            color: Colors.black,
                          ),
                          tooltip:
                              searchBarVisible
                                  ? 'Fechar pesquisa'
                                  : 'Pesquisar',
                        ),
                        // Avatar do usuário
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfileScreen(),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 18,
                              backgroundImage: currentUser.profileImage.build(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            // Conteúdo principal
            ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: bookTiles.length,
              itemBuilder: (context, index) => bookTiles[index],
            ),

            // Sugestões do autocomplete
            if (showSuggestions && searchBarVisible)
              Positioned(
                top: 10,
                left: 25,
                right: 25,
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    constraints: BoxConstraints(maxHeight: 250),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: bookSuggestions.length,
                        separatorBuilder:
                            (context, index) =>
                                Divider(height: 1, color: Colors.grey.shade100),
                        itemBuilder: (context, index) {
                          final suggestion = bookSuggestions[index];
                          final query = _controller.text.trim();

                          return InkWell(
                            onTap: () => _selectSuggestion(suggestion),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.book,
                                    color: const Color.fromARGB(
                                      255,
                                      160,
                                      102,
                                      16,
                                    ),
                                    size: 22,
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        children: _buildHighlightedText(
                                          suggestion,
                                          query,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.search,
                                    color: Colors.grey[400],
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<TextSpan> _buildHighlightedText(String text, String query) {
    if (query.isEmpty) {
      return [
        TextSpan(
          text: text,
          style: TextStyle(color: Colors.black87, fontSize: 16),
        ),
      ];
    }

    List<TextSpan> spans = [];
    String lowerText = text.toLowerCase();
    String lowerQuery = query.toLowerCase();

    // Encontrar todas as posições onde a query aparece no texto
    List<int> matchIndexes = [];
    int searchFrom = 0;

    while (true) {
      int index = lowerText.indexOf(lowerQuery, searchFrom);
      if (index == -1) break;
      matchIndexes.add(index);
      searchFrom = index + 1;
    }

    if (matchIndexes.isEmpty) {
      // Se não encontrou correspondência direta, tentar busca por palavras
      List<String> queryWords = query.toLowerCase().split(RegExp(r'\s+'));
      List<String> textWords = text.toLowerCase().split(RegExp(r'\s+'));

      // Procurar por palavras que começam com qualquer palavra da query
      for (int i = 0; i < textWords.length; i++) {
        for (String queryWord in queryWords) {
          if (queryWord.length >= 2 && textWords[i].startsWith(queryWord)) {
            int wordStart = 0;
            for (int j = 0; j < i; j++) {
              wordStart += textWords[j].length + 1; // +1 para o espaço
            }
            matchIndexes.add(wordStart);
            break;
          }
        }
      }
    }

    if (matchIndexes.isEmpty) {
      return [
        TextSpan(
          text: text,
          style: TextStyle(color: Colors.black87, fontSize: 16),
        ),
      ];
    }

    // Ordenar os índices
    matchIndexes.sort();

    int currentPos = 0;

    for (int matchIndex in matchIndexes) {
      // Adicionar texto antes da correspondência
      if (matchIndex > currentPos) {
        spans.add(
          TextSpan(
            text: text.substring(currentPos, matchIndex),
            style: TextStyle(color: Colors.black87, fontSize: 16),
          ),
        );
      }

      int matchLength = query.length;

      // Se não é uma correspondência direta, encontrar o comprimento da palavra
      if (!lowerText.substring(matchIndex).startsWith(lowerQuery)) {
        String remainingText = text.substring(matchIndex);
        List<String> words = remainingText.split(RegExp(r'\s+'));
        if (words.isNotEmpty) {
          matchLength = words[0].length;
        }
      }

      // Garantir que não ultrapasse o comprimento do texto
      int endIndex = (matchIndex + matchLength).clamp(0, text.length);

      // Adicionar texto destacado
      spans.add(
        TextSpan(
          text: text.substring(matchIndex, endIndex),
          style: TextStyle(
            color: const Color.fromARGB(255, 138, 101, 7),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      );

      currentPos = endIndex;
    }

    // Adicionar o resto do texto, se houver
    if (currentPos < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(currentPos),
          style: TextStyle(color: Colors.black87, fontSize: 16),
        ),
      );
    }

    return spans;
  }
}
