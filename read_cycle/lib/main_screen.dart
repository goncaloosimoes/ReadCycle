import 'package:flutter/material.dart';
import 'package:read_cycle/pages/chat_screen.dart';
import 'package:read_cycle/pages/home_screen.dart';
import 'package:read_cycle/pages/post_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _selectedIdx = 0;
  final int _numNotifications = 2; // modificar depois

  final List<Widget> screenWidgets = [
    HomeScreen(),
    PostScreen(),
    ChatScreen(),
  ];

  void _changeIdx(int index) {
    setState(() {
      _selectedIdx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      body: screenWidgets[_selectedIdx],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: isKeyboardOpen
          ? null
          : SizedBox(
              height: 70,
              width: 70,
              child: FloatingActionButton(
                onPressed: () => _changeIdx(1),
                backgroundColor: const Color.fromARGB(255, 199, 156, 28),
                shape: CircleBorder(),
                child: Icon(Icons.add, size: 40),
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 7,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              iconSize: 35,
              icon: Icon(
                _selectedIdx == 0 ? Icons.home_filled : Icons.home_outlined,
              ),
              onPressed: () => _changeIdx(0),
            ),
            SizedBox(width: 20),
            IconButton(
              iconSize: 35,
              icon: Badge(
                label: Text(_numNotifications.toString()),
                child: Icon(
                  _selectedIdx == 2 ? Icons.chat : Icons.chat_outlined,
                ),
              ),
              onPressed: () => _changeIdx(2),
            ),
          ],
        ),
      ),
    );
  }

}
