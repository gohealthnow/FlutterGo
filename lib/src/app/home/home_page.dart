import 'package:flutter/material.dart';
import 'package:gohealth/src/components/Pharmacy/pharmacy.dart';
import 'package:gohealth/src/components/side_menu.dart';
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
            PharmacyComponent(),
          ],
        ),
      ),
    );
  }
}
