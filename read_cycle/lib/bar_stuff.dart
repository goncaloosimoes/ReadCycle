import 'package:flutter/material.dart';
import 'package:read_cycle/data/chats.dart';
import 'package:read_cycle/main.dart';
import 'package:read_cycle/pages/chat_screen.dart';
import 'package:read_cycle/pages/home_screen.dart';
import 'package:read_cycle/pages/post_screen.dart';

int selectedIdx = 0;

final List<Widget> screenWidgets = [
  HomeScreen(),
  PostScreen(),
  ChatScreen(),
];

void _changeIdx(int index, BuildContext context) {
  Navigator.of(context).popUntil((route) => route.isFirst);
  selectedIdx = index;
  mainScreenKey.currentState?.update(); // Atualiza o main para mudor o ecrã
}

class MainBar extends StatefulWidget {
  const MainBar({super.key});

  @override
  State<StatefulWidget> createState() => _MainState();
}

class _MainState extends State<MainBar> {
  
  // Atualiza o state
  void update(int? index) {
    setState(() {
      if (index != null) {
        _changeIdx(index, context);
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            iconSize: 35,
            icon: Icon(
              selectedIdx == 0 ? Icons.home_filled : Icons.home_outlined,
            ),
            onPressed: () => update(0),
          ),
          SizedBox(width: 20),
          IconButton(
            iconSize: 35,
            icon: Badge(
              isLabelVisible: getNumNotifications() > 0,
              label: Text(getNumNotifications().toString()),
              child: Icon(
                selectedIdx == 2 ? Icons.chat : Icons.chat_outlined,
              ),
            ),
            onPressed: () => update(2),
          ),
        ],
      ),
    );
  }
}

class CreatePostButton extends StatelessWidget {
  const CreatePostButton({super.key});
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 70,
      child: FloatingActionButton(
        heroTag: null,
        onPressed: () => _changeIdx(1, context),
        backgroundColor: const Color.fromARGB(255, 199, 156, 28),
        shape: CircleBorder(),
        child: Icon(Icons.add, size: 40),
      ),
    );
  }
}