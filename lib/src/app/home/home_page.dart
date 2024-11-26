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
  Future<void> _refresh() async {
    await Future.delayed(
        const Duration(seconds: 2)); // Simulação de uma atualização
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: const HeaderBarState(),
        drawer: const SideMenu(),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Farmácias perto de você',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: screenHeight * 0.2,
                    ),
                    child: const PharmacyComponentState(),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Produtos perto de você',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: screenHeight * 0.2,
                    ),
                    child: const BannerComponent(hasPromotion: false),
                  ),
                  Divider(),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Produtos em promoção',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Exibição de catalogo de varios tipo de produtos
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: screenHeight * 0.2,
                    ),
                    child: const BannerComponent(hasPromotion: true),
                  ),
                  ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: screenHeight * 0.2,
                      ),
                      child: const Divider()),
                  Expert(),
                ],
              ),
            ),
          ),
        ));
  }
}
