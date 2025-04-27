
import 'package:flutter/material.dart';
import 'package:read_cycle/classes/post.dart';
import 'package:read_cycle/components/search_result.dart';
import 'package:read_cycle/data/posts.dart';

class SearchScreen extends StatefulWidget {
  final String searchText;
  const SearchScreen(this.searchText, {super.key});

  @override
  State<SearchScreen> createState() =>  _MainState();
}

class _MainState extends State<SearchScreen> {
  String searchText = "";
  final TextEditingController _controller = TextEditingController();
  List<SearchResult> searchResults = [];

  _MainState();

  void reloadPage() {
    setState(() {
      searchText = _controller.text;
      getRelevantPosts();
    });
  }

  void getRelevantPosts() {
    searchResults = [];
    
    // Listar posts relevantes
    for (Post post in appPosts) {
      if (searchText.toLowerCase().contains(post.book.title.toLowerCase())) {
        searchResults.add(SearchResult(post: post));
      }
      else if (post.book.title.toLowerCase().contains(searchText.toLowerCase())) {
        searchResults.add(SearchResult(post: post));
      }
    }
  }

  @override
  void initState() {
    super.initState();

    // Definir valores iniciais
    _controller.text = widget.searchText;
    searchText = widget.searchText;

    getRelevantPosts();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            elevation: 0,
            flexibleSpace: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 180,
                      child: TextField(
                        controller: _controller,
                        onSubmitted: (value) {
                          reloadPage();
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                          fillColor: Color.fromARGB(255, 241, 241, 241),
                          filled: true,
                          hintText: 'Pesquisa...',
                        ),
                      )
                    ),
                    IconButton(
                      onPressed: reloadPage,
                      icon: const Icon(Icons.search)
                    ),
                  ],
                ),
            )
          ),
        )
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          
          itemCount: searchResults.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Text(
                "Resultados para \"$searchText\"",
                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
              ));
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: searchResults[index - 1]
            );
          },
        )
      ),
    );
  }
}