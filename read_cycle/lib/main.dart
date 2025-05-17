import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:read_cycle/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown, // Permite de cabeça para baixo
  ]);
  runApp(const MyApp());
}

// Chave para poder interagir com o estado do mainScreen
final GlobalKey<MainScreenState> mainScreenKey = GlobalKey();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ReadCycle',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 247, 193, 31)),
      ),
      home: MainScreen(key: mainScreenKey),
    );
  }
}
