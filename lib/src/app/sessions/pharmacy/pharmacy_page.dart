import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gohealth/api/models/pharmacy_model.dart';
import 'package:gohealth/api/models/product_models.dart';
import 'package:gohealth/api/repositories/product_repository.dart';
import 'package:gohealth/api/services/http_client.dart';
import 'package:gohealth/src/app/sessions/pharmacy/pharmacy_controller.dart';
import 'package:gohealth/src/app/sessions/products/product_page.dart';

class PharmacyPage extends StatefulWidget {
  const PharmacyPage({super.key, required this.pharmacy});

  final PharmacyModels pharmacy;

  @override
  _PharmacyPageState createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
  final PharmacyPageController controller = PharmacyPageController();

  final ProductRepository productRepository = ProductRepository();

  List<ProductModels> products = [];

  Future<void> getProducts() async {
    var productIds =
        widget.pharmacy.pharmacyProducts!.map((e) => e.productId!).toList();
    for (var id in productIds) {
      var product = await productRepository.getbyId(id);
      setState(() {
        products.add(product);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pharmacy.name!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.pharmacy.image ??
                      "https://via.placeholder.com/150"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              widget.pharmacy.name!,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              widget.pharmacy.phone!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Produtos disponíveis na ${widget.pharmacy.name!}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductPage(
                                  productModels: products[index],
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.primaries[Random()
                                      .nextInt(Colors.primaries.length)],
                                  radius: 50,
                                  child: products[index].image != null
                                      ? ClipOval(
                                          child: Image.network(
                                            products[index].image!,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Text(
                                          products[index].name!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        ),
                                ),
                                Text(products[index].name!),
                                const SizedBox(height: 5),
                                Text(
                                  "R\$" + products[index].price!.toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
