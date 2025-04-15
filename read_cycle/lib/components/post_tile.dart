import 'package:flutter/material.dart';
import 'package:read_cycle/classes/post.dart';

class PostTile extends StatelessWidget {
  final Post post;
  const PostTile({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 242, 241, 241),
        borderRadius: BorderRadius.circular(10)
      ),
      margin: EdgeInsets.only(left: 20),
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            post.bookImage,
            height: 100,
          ),
          Text(
            post.bookTitle,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  post.userName,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 114, 114, 114),
                  ),
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20,
                ),
                Text(
                  post.userRating,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 114, 114, 114),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}