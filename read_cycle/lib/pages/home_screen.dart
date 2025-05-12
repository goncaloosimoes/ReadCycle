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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void searchButtonFunctionality() {
    if (!searchBarVisible) {
      setState(() {
        searchBarVisible = !searchBarVisible;
      });
    } else if (_controller.text.trim().isNotEmpty) {
      // Passar para a página de pesquisa
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchScreen(_controller.text.trim()),
        ),
      );
    }
  }

  void hideSearchBar() {
    setState(() {
      searchBarVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    final List<PostTile> suggestionTiles = [
      fictionTiles[2],
      thrillerTiles[0],
      romanceTiles[4],
      thrillerTiles[2]
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200, // enough width for interaction
                      height: 60,
                      child: Stack(
                        alignment: AlignmentDirectional.centerStart,
                        clipBehavior: Clip.none,
                        children: [
                          Text(
                            'ReadCycle',
                            style: TextStyle(color: Colors.black, fontSize: 25),
                          ),
                          Positioned(
                            left: 20,
                            width: 180,
                            child: Visibility(
                              visible: searchBarVisible,
                              maintainSize: true,
                              maintainState: true,
                              maintainAnimation: true,
                              child: TextField(
                                controller: _controller,
                                onSubmitted: (value) {
                                  // Passar para a página de pesquisa
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SearchScreen(_controller.text),
                                    ),
                                  );
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                  
                                  fillColor: Color.fromARGB(255, 241, 241, 241),
                                  filled: true,
                                  hintText: 'Pesquisa...',
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: searchButtonFunctionality,
                          icon: const Icon(Icons.search),
                        ),
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
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 28,
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
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: bookTiles.length,
          itemBuilder: (context, index) => bookTiles[index],
        ),
      ),
    );
  }
}