import 'package:flutter/material.dart';
import 'package:gohealth/src/components/banner.dart';
import 'package:gohealth/src/components/pharmacy.dart';
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
    return Scaffold(
      appBar: const HeaderBarState(),
      drawer: const SideMenu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Farmácias perto de você',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 100),
              child: const PharmacyComponentState(),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Farmácias perto de você',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 500),
              child: const BannerComponent(),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
