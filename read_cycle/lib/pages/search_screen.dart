
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final String searchText;
  const SearchScreen(this.searchText, {super.key});

  @override
  State<SearchScreen> createState() =>  _MainState();
}

class _MainState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  _MainState();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.searchText;
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 180,
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                          fillColor: Color.fromARGB(255, 241, 241, 241),
                          filled: true,
                          hintText: 'Pesquisa...',
                        ),
                      )
                    )
                  ],
                ),
            )
          ),
        )
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Text(
              "Resultados para \"${widget.searchText}\"",
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}