import 'package:flutter/material.dart';
import 'package:gohealth/src/interfaces/login_page.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoHealth',
      theme: ThemeData(
        colorSchemeSeed: const Color.fromARGB(255, 0, 91, 226),
        fontFamily: 'Rubik',
      ),
      home: const LoginPage(),
    );
  }
}
