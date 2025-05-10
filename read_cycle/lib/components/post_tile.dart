import 'package:flutter/material.dart';
import 'package:read_cycle/classes/post.dart';
import 'package:read_cycle/pages/book_details_screen.dart';

class PostTile extends StatelessWidget {
  final Post post;
  const PostTile({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailsScreen(post: post,),
          )
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 246, 237, 218),
          borderRadius: BorderRadius.circular(10)
        ),
        margin: EdgeInsets.only(left: 20),
        padding: EdgeInsets.all(25),
        child: SizedBox(
          width: 110,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: post.postBook.coverImage.build(),
                height: 110,
              ),
              Text(
                post.postBook.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              Text(
                post.postBook.author,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12
                ),
              ),
              SizedBox(
                width: 110,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 60,
                      child: Text(
                        post.postUser.rating,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 114, 114, 114),
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Row(
                     children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                        Text(
                          post.postUser.rating,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 114, 114, 114),
                            fontWeight: FontWeight.bold,
                            fontSize: 12
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}