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

  final List<Widget> screenWidgtes = [
    HomeScreen(),
    PostScreen(),
    ChatScreen(),
  ];

  void changeIdx(int index) {
    setState(() {
      _selectedIdx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenWidgtes[_selectedIdx],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.deepPurple.shade100
        ),
        child: NavigationBar(
          // backgoundcolor
          selectedIndex: _selectedIdx,
          onDestinationSelected: changeIdx,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home),
              selectedIcon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.add_outlined),
              selectedIcon: Icon(Icons.add),
              label: 'Add Book',
            ),
            NavigationDestination(
              icon: Icon(Icons.chat_outlined),
              selectedIcon: Icon(Icons.chat),
              label: 'Chat',
            ),
          ],
        ),
      ),
    );
  }
}