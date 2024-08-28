import 'package:flutter/material.dart';
import 'package:gohealth/src/components/Pharmacy/pharmacy_controller.dart';

class Farmacia extends StatefulWidget {
  const Farmacia({super.key});

  @override
  _FarmaciaState createState() => _FarmaciaState();
}

class _FarmaciaState extends State<Farmacia> {
  final PharmacyController controller = PharmacyController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Farmácias perto de você',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.nearbyPharmacies.length,
            itemBuilder: (context, index) {
                return GestureDetector(
                onTap: () {
                  // * Navegar para a página da farmácia de acordo com ID dela ou sei lá, o jeito que eu vou fazer isso não faço a minima ideia.
                },
                child: CircleAvatar(
                  backgroundColor: controller.nearbyPharmacies[index],
                  radius: 25,
                ),
                );
            },
          ),
        ),
      ],
    );
  }
}
