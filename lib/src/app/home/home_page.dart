import 'package:flutter/material.dart';
import 'package:gohealth/src/app/home/side_menu.dart';
import 'package:gohealth/src/components/header_bar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  HomepageState createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HeaderBarState(),
      drawer: SideMenu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 50),
            Text('Bem-vindo ao GoHealth!'),
            SizedBox(height: 50),
            Text('Aqui você encontra tudo para sua saúde.'),
            SizedBox(height: 50),
            Text('Aproveite!'),
          ],
        ),
      ),
    );
  }
}
