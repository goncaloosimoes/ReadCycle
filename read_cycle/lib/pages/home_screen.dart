import 'package:flutter/material.dart';
import 'package:read_cycle/classes/book.dart';
import 'package:read_cycle/classes/post.dart';
import 'package:read_cycle/classes/user.dart';
import 'package:read_cycle/components/post_tile.dart';
import 'package:read_cycle/pages/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<User> users = [
    User(name: 'Emma', email: 'emma@email.com', profileImagePath: 'assets/images/persona2.jpg', rating: '4.5')
  ];

  final List<Book> books = [
    Book(title: 'Ficciones', author: 'Jorge Luis Borges', pages: 203, genres: ['Fiction', 'Fantasy'], coverImagePath: 'assets/images/Ficciones.jpg', description: 'The seventeen pieces in Ficciones demonstrate the whirlwind of Borges\'s...')
  ];


  @override
  Widget build(BuildContext context) {

    final List<Post> posts = [
      Post(user: users[0], book: books[0], location: 'Aveiro', date: DateTime.now(), imagePaths: []),
      Post(user: users[0], book: books[0], location: 'Aveiro', date: DateTime.now(), imagePaths: []),
      Post(user: users[0], book: books[0], location: 'Aveiro', date: DateTime.now(), imagePaths: [])
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
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                  GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const ProfileScreen())
                    );
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                        radius: 28,
                        backgroundImage: AssetImage('assets/images/persona2.jpg'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // sugestões
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
            child: Text(
              'Sugestões',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 5,),
          SizedBox(
            height: 200,
            child: Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: posts.length,
                itemBuilder: (context, index) => PostTile(post: posts[index]),
              ),
            ),
          ),
          const SizedBox(height:  5,),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
            child: Text(
              'Ficção',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 5,),
          SizedBox(
            height: 200,
            child: Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: posts.length,
                itemBuilder: (context, index) => PostTile(post: posts[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}