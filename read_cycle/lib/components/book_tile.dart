import 'package:flutter/material.dart';
import 'package:read_cycle/classes/book.dart';
import 'package:read_cycle/data/posts.dart';
import 'package:read_cycle/pages/book_details_screen.dart';
import 'package:read_cycle/data/time.dart';
import 'package:read_cycle/classes/post.dart';

class BookTile extends StatelessWidget {
  final Book book;
  const BookTile({super.key, required this.book,});

  @override
  Widget build(BuildContext context) {
    Post matchingPost = appPosts.firstWhere(
          (p) => p.postBook.title == book.title && p.postBook.author == book.author,
        );
    //print(matchingPost.book.title);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailsScreen(post: matchingPost)
          )
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 226, 226, 226),
          borderRadius: BorderRadius.circular(2)
        ),
        child: Row(
          children: [
            Image.asset(
              book.coverImagePath,
              height: 110,
              width: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    book.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    book.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13
                    ),
                  ),
                  Text(
                    calculateDays(matchingPost),
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}