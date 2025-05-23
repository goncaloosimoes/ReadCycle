import 'package:flutter/material.dart';
import 'package:read_cycle/bar_stuff.dart';
import 'package:read_cycle/classes/post.dart';
import 'package:read_cycle/data/chats.dart';
import 'package:read_cycle/data/time.dart';
import 'package:read_cycle/data/users.dart';
import 'package:read_cycle/pages/chat_detail_screen.dart';
import 'package:read_cycle/pages/others_profile_screen.dart';
import 'package:read_cycle/pages/profile_screen.dart';

class BookDetailsScreen extends StatefulWidget {
  final Post post;
  const BookDetailsScreen({super.key, required this.post});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreen();
}


class _BookDetailsScreen extends State<BookDetailsScreen> {

  bool isExpandedDescription = false;
  bool isExpandedNotes = false;

  @override
  Widget build(BuildContext context) {
    final Post post = widget.post;
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                            child: Image(
                              image: post.postBook.coverImage.build(),
                              fit: BoxFit.contain
                            ),
                          ),
                        ),
                      )
                    );
                  },
                  child: Image(
                    image: post.postBook.coverImage.build(),
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
                        post.postBook.title,
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
                        post.postBook.author,
                        style: TextStyle(fontSize: 17),
                      ),
                      const SizedBox(height: 4,),
                      Text(
                        '${post.postBook.pages.toString()} páginas',
                        style: TextStyle(fontSize: 14),
                      ),
                      Container( // generos do livro
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: post.postBook.genres.map((genre) {
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
                      const SizedBox(height: 20,),
                      Text(
                        '${post.location}, ${calculateDays(post)}',
                        style: TextStyle(
                          fontSize: 14,
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => (post.postUser == currentUser) ? ProfileScreen() : OthersProfileScreen(user: post.postUser),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      radius: 38,
                      backgroundImage: post.postUser.profileImage.build(),
                    ),
                  ),
                ),
                const SizedBox(width: 8,),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OthersProfileScreen(user: post.postUser,),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.postUser.name,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              post.postUser.rating,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15
                              ),
                            ),
                            Icon(
                              Icons.star,
                                color: Colors.amber,
                                size: 20,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (post.postUser != currentUser)
                  Container(
                    margin: const EdgeInsets.only(left: 5,),
                    child: ElevatedButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatDetailScreen(chat: chats.firstWhere((chat) => chat.user == post.postUser)),
                          ),
                        )
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: const Text(
                          'Iniciar\nChat',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 25,),
            const Text(
              'Descrição',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            const Divider(),
            const SizedBox(height: 10,),
            LayoutBuilder(
              builder: (context, constraints) {
                final maxLines = isExpandedDescription ? null : 4;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.postBook.description,
                      style: TextStyle(fontSize: 14),
                      maxLines: maxLines,
                      overflow: isExpandedDescription ? TextOverflow.visible : TextOverflow.ellipsis,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpandedDescription = !isExpandedDescription;
                        });
                      },
                      child: Text(
                        isExpandedDescription ? 'Ver menos' : 'Ver mais',
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
            const SizedBox(height: 25,),
            const Text(
              'Notas',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            const Divider(),
            const SizedBox(height: 10,),
            LayoutBuilder(
              builder: (context, constraints) {
                final hasNotes = post.postNotes.trim().isNotEmpty;
                final text = hasNotes ? post.postNotes : 'Sem notas';
                final maxLines = isExpandedNotes ? null : 4;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: TextStyle(fontSize: 14),
                      maxLines: maxLines,
                      overflow: isExpandedNotes ? TextOverflow.visible : TextOverflow.ellipsis,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpandedNotes = !isExpandedNotes;
                        });
                      },
                      child: Text(
                        isExpandedNotes ? 'Ver menos' : 'Ver mais',
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
            const SizedBox(height: 25,),
            const Text(
              'Fotografias',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            const Divider(),
            const SizedBox(height: 10,),
            SizedBox(
            height: 220,
            child: Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: post.images.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(right: 5),
                    child: GestureDetector(
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
                              child: Image(
                                  image: post.images[index].build(),
                                  fit: BoxFit.contain
                                ),
                              ),
                            ),
                          )
                        );
                      },
                        child: Image(
                          image: post.images[index].build(),
                          height: 230,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                  );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: isKeyboardOpen
          ? null
          : const CreatePostButton(),
      bottomNavigationBar: MainBar(),
    );
  }
}