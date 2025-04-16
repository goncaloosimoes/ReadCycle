import 'package:flutter/material.dart';
import 'package:read_cycle/components/books_tile.dart';
import 'package:read_cycle/components/post_tile.dart';
import 'package:read_cycle/pages/profile_screen.dart';
import 'package:read_cycle/data/posts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _MainState();
}

class _MainState extends State<HomeScreen> {
  bool searchBarVisible = false;

  void toggleSearchBarVisibility() {
    searchBarVisible = !searchBarVisible;
    if (searchBarVisible) {
      print("show!");
    }
  }

  @override
  Widget build(BuildContext context) {
    
    final List<PostTile> postTiles = [
      PostTile(post: appPosts[0]),
      PostTile(post: appPosts[1]),
      PostTile(post: appPosts[2]),
      PostTile(post: appPosts[3]),
      PostTile(post: appPosts[4]),
      PostTile(post: appPosts[5]),
      PostTile(post: appPosts[6]),
    ];
    

    final List<BooksTile> bookTiles = [
      BooksTile(title: 'Sugestões', postTiles: postTiles),
      BooksTile(title: 'Ficção', postTiles: postTiles.sublist(3)),
      BooksTile(title: 'Biografias', postTiles: postTiles),
      BooksTile(title: 'Comédia', postTiles: postTiles),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          elevation: 0,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'ReadCycle',
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  Visibility(
                    visible: searchBarVisible,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Color.fromARGB(255, 0, 255, 255),
                        hintText: 'Enter a search term',
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: toggleSearchBarVisibility,
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
                            backgroundImage: AssetImage(
                              'assets/images/persona2.jpg',
                            ),
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
    );
  }
}