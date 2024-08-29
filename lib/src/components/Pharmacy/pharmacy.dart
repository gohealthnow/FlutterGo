import 'package:flutter/material.dart';
import 'package:gohealth/src/components/Pharmacy/pharmacy_controller.dart';

class PharmacyComponent extends StatefulWidget {
  const PharmacyComponent({super.key});

  @override
  _PharmacyState createState() => _PharmacyState();
}

class _PharmacyState extends State<PharmacyComponent> {
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
                  // Navegar para a página da farmácia de acordo com ID dela ou outro método
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        controller.nearbyPharmacies[index].pharmacy?.name ?? '',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
