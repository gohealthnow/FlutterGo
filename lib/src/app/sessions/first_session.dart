import 'package:flutter/material.dart';

class firstSession extends StatefulWidget {
  const firstSession({super.key});

  @override
  State<firstSession> createState() => _FirstSessionState();
}

class _FirstSessionState extends State<firstSession> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Form(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(),
        ),
      ),
    );
  }
}
