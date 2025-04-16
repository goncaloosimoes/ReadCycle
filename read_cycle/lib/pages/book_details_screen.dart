import 'package:flutter/material.dart';
import 'package:read_cycle/classes/post.dart';
import 'package:read_cycle/data/time.dart';

class BookDetailsScreen extends StatelessWidget {

  final Post post;

  const BookDetailsScreen({super.key, required this.post});

  String calculateDays() {
    final postDate = post.date;
    final difference = appStartTime.difference(postDate).inDays;
    if (difference == 0) return 'Hoje';  
    if (difference == 1) return 'Há 1 dia';
    return 'Há $difference dias';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary,),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row( // informações principais do livro
              children: [
                Column( // imagem do livro
                  children: [
                    Image.asset(
                      post.bookImage,
                      height: 230,
                    ),
                  ],
                ),
                Column( // infos do livro
                  children: [
                    Text(
                      post.bookTitle,
                    ),
                    Text(
                      post.bookAuthor,
                    ),
                    Text(
                      '${post.bookPages.toString()} páginas',
                    ),
                    Container( // generos do livro

                    ),
                    Text(
                      '${post.location}, ${calculateDays()}',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}