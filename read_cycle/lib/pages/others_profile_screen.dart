import 'package:flutter/material.dart';
import 'package:read_cycle/classes/user.dart';
import 'package:read_cycle/components/book_tile.dart';

class OthersProfileScreen extends StatefulWidget {
  final User user;
  const OthersProfileScreen({super.key, required this.user});

  @override
  State<OthersProfileScreen> createState() => _OthersProfileScreen();
}


class _OthersProfileScreen extends State<OthersProfileScreen> {

  bool isExpandedBio = false;

  @override
  Widget build(BuildContext context) {
    final User user = widget.user;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage: user.profileImage.build(),
                  ),
                ),
                const SizedBox(width: 15,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            user.rating,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 20
                            ),
                          ),
                          const Icon(
                            Icons.star,
                              color: Colors.amber,
                              size: 25,
                          )
                        ],
                      ),
                      Text( // não implementado
                        '10 criticas',
                        style: const TextStyle(
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            const Divider(),
            const SizedBox(height: 10,),
            LayoutBuilder(
              builder: (context, constraints) {
                final maxLines = isExpandedBio ? null : 4;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.bio,
                      style: const TextStyle(fontSize: 14),
                      maxLines: maxLines,
                      overflow: isExpandedBio ? TextOverflow.visible : TextOverflow.ellipsis,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpandedBio = !isExpandedBio;
                        });
                      },
                      child: Text(
                        isExpandedBio ? 'Ver menos' : 'Ver mais',
                        style: TextStyle(
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      size: 25,
                    ),
                    Text(
                      user.location,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    // <a href="https://www.flaticon.com/free-icons/transaction" title="transaction icons">Transaction icons created by feen - Flaticon</a>
                    Image.asset(
                      'assets/images/transaction.png',
                      width: 25,
                      height: 25,
                    ),
                    SizedBox(width: 5,),
                    Text(
                      '${user.numTrades} trocas',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20,),
            const Text(
              'Géneros Preferidos',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            const Divider(),
            Container( // generos do livro
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: user.favGenres.map((genre) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      genre,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20,),
            const Text(
              'Livros',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            const Divider(),
            SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: user.books.length,
              itemBuilder: (context, index) => BookTile(book: user.books[index], user: user,),
            ),
          ),
          ],
        ),
      ),
    );
  }
}