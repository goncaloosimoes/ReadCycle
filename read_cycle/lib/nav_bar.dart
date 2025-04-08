import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavAppState();
}

class _NavAppState extends State<NavBar> {
  int currentPageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIdx = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIdx,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_max_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.add),
            label: 'Add Book',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('10'),
              child: Icon(Icons.chat),
            ),
            label: 'Chat',
          ),
        ],
      ),
    );
  }
}