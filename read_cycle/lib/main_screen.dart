import 'package:flutter/material.dart';
import 'package:read_cycle/bar_stuff.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      body: screenWidgets[selectedIdx],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: isKeyboardOpen
          ? null
          : const CreatePostButton(),
      bottomNavigationBar: MainBar(),
    );
  }
}
