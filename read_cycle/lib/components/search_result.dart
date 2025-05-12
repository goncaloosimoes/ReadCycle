import 'package:flutter/material.dart';
import 'package:read_cycle/classes/post.dart';
import 'package:read_cycle/pages/book_details_screen.dart';

class SearchResult extends StatelessWidget {
  final Post post;
  const SearchResult({super.key, required this.post});

  String getPostDays() {
    DateTime now = DateTime.now();
    int daysDifference = now.difference(post.date).inDays;

    if (daysDifference == 0) {
      return "📅 Hoje";
    }

    return "📅 Há $daysDifference dias";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Mudar para a página do post associado
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookDetailsScreen(post: post)),
        );
      },
      child: SizedBox(
        height: 150,
        child: ColoredBox(
          color: const Color.fromARGB(255, 246, 237, 218),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Image(
                      image: post.book.coverImage.build(),
                      height: 120,
                    )
                  )
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        post.book.title,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        post.book.author,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        "${post.book.pages} páginas",
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        "${post.user.name} ${post.user.rating} ⭐",
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 12.5,
                        ),
                      ),
                    ],
                  )
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("📍 ${post.location}"),
                      Text(getPostDays()),
                    ],
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}