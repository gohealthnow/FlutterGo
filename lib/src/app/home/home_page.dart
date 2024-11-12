import 'package:flutter/material.dart';
import 'package:gohealth/src/components/checklist/Expert.dart';
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
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const HeaderBarState(),
      drawer: const SideMenu(),
      body: SingleChildScrollView(
        child: Center(
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
                constraints: BoxConstraints(
                  maxHeight: screenHeight * 0.2, // 20% da altura da tela
                ),
                child: const PharmacyComponentState(),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Produtos perto de você',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: screenHeight * 0.2, // 60% da altura da tela
                ),
                child: const BannerComponent(hasPromotion: false),
              ),
              Divider(),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Produtos em promoção',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: screenHeight * 0.2, // 60% da altura da tela
                ),
                child: const BannerComponent(hasPromotion: true),
              ),
              Divider(),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: screenHeight * 0.3, // 60% da altura da tela
                ),
                child: Expert(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
