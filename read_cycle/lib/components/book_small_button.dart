import 'package:flutter/material.dart';
import 'package:read_cycle/classes/book.dart';

class BookSmallButton extends StatefulWidget {
  final Book book;
  final Function(bool) onSelectChange;
  final bool selected;
  const BookSmallButton({super.key, required this.book, required this.onSelectChange, this.selected = false});
  
  @override
  State<BookSmallButton> createState() => _MainState();
}

class _MainState extends State<BookSmallButton> { 
  bool selected = false;
  
  @override
  void initState() {
    super.initState();
    selected = widget.selected;
    widget.onSelectChange(selected);
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
          widget.onSelectChange(selected);
        });
      },
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Container(
            width: 100,
            height: 110,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 226, 226, 226),
                borderRadius: BorderRadius.circular(10),

            ),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(widget.book.coverImagePath),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Text(
                  widget.book.title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            )
          ),
          Container(
            width: 100,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: (selected)?Colors.black.withAlpha(102):Colors.transparent, // Dark tint
            ),
          ),
        ],
      )
    );
  }
}