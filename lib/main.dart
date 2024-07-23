import 'package:flutter/material.dart';
import 'package:gohealth/src/interfaces/login_page.dart';
import 'package:gohealth/src/styles/new_theme.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoHealth',
      theme: newTheme,
      home: const LoginPage(),
    );
  }
}
