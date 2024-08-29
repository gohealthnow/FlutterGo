import 'package:flutter/material.dart';
import 'package:gohealth/src/app/sessions/pharmacy/pharmacy_controller.dart';

class PharmacyPage extends StatefulWidget {
  const PharmacyPage({super.key});

  @override
  _PharmacyPageState createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {

  final PharmacyPageController controller = PharmacyPageController();

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);

  }

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // mostrar os dados da farmácia que o usuario clicou
         
      ],
    );
  }
}
