import 'package:flutter/material.dart';
import 'package:read_cycle/classes/book.dart';

class BookSmallTile extends StatelessWidget {
  final Book book;
  const BookSmallTile({super.key, required this.book,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: book.coverImage.build(),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Text(
          book.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}