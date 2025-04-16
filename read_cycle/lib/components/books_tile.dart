import 'package:flutter/material.dart';
import 'package:read_cycle/components/post_tile.dart';

class BooksTile extends StatelessWidget {
  const BooksTile({super.key, required this.title, required this.postTiles});
  
  final String title;
  final List<PostTile> postTiles;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // sugestões
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 220,
            child: Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: postTiles.length,
                itemBuilder: (context, index) => postTiles[index],
              ),
            ),
          ),
          SizedBox(height: 5,),
        ],
      );
  }
}