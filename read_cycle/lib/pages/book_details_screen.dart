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
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => Dialog(
                        backgroundColor: Colors.transparent,
                        insetPadding: EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: InteractiveViewer(
                            child: Image.asset(
                              post.bookImage,
                              fit: BoxFit.contain
                            ),
                          ),
                        ),
                      )
                    );
                  },
                  child: Image.asset(
                    post.bookImage,
                    height: 230,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: Column( // infos do livro
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.bookTitle,
                        maxLines: 2,
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                          height: 1.1,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3,),
                      Text(
                        post.bookAuthor,
                        style: TextStyle(fontSize: 17),
                      ),
                      const SizedBox(height: 4,),
                      Text(
                        '${post.bookPages.toString()} páginas',
                        style: TextStyle(fontSize: 14),
                      ),
                      Container( // generos do livro
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: post.bookGenres.map((genre) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                genre,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 8,),
                      Text(
                        '${post.location}, ${calculateDays()}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}