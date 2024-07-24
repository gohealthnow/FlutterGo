import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GoHealth'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Olá, Gabriel Oliveira'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implementar ação de logout
              },
              child: const Text('Sair'),
            ),
          ],
        ),
      ),
    );
  }
}
