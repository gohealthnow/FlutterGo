import 'package:flutter/material.dart';
import 'package:gohealth/src/components/input_bar.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: InputBar(icon: Icons.send),
        ),
      ),
    );
  }
}
