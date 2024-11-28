import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gohealth/api/models/pharmacy_model.dart';
import 'package:gohealth/api/models/product_models.dart';
import 'package:gohealth/api/repositories/product_repository.dart';
import 'package:gohealth/src/app/sessions/pharmacy/pharmacy_controller.dart';
import 'package:gohealth/src/app/sessions/products/product_page.dart';
import 'package:url_launcher/url_launcher.dart';

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

  void _launchMaps(String address) async {
    final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=${Uri.encodeFull(address)}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.pharmacy.image ?? "https://via.placeholder.com/150",
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              title: Text(
                widget.pharmacy.name!,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Card(
                      elevation: 4,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.9,
                          minWidth: MediaQuery.of(context).size.width * 0.9,
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.phone, color: Colors.blue),
                                SizedBox(width: 8),
                                Text(
                                  widget.pharmacy.phone!,
                                  style: TextStyle(
                                    color: Color(0xff1d1b20),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.3,
                                    height: 1.4,
                                    leadingDistribution:
                                        TextLeadingDistribution.even,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 16),
                            Row(
                              children: [
                                Icon(Icons.location_on, color: Colors.blue),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () => _launchMaps(widget.pharmacy.geolocation!.address ?? ""),
                                  child: Text(
                                    (widget.pharmacy.geolocation!.address ?? "").length > 19
                                        ? "${widget.pharmacy.geolocation!.address!.substring(0, 19)}..."
                                        : widget.pharmacy.geolocation!.address ?? "",
                                    style: TextStyle(
                                      color: Color(0xff1d1b20),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.3,
                                      height: 1.4,
                                      decoration: TextDecoration.underline,
                                      leadingDistribution: TextLeadingDistribution.even,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar produtos...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                  ),
                ],
              ),
            ),
          ),
          products.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SliverPadding(
                  padding: EdgeInsets.all(16),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductPage(productModels: products[index]),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(12),
                                      ),
                                      color: Colors.primaries[Random()
                                          .nextInt(Colors.primaries.length)],
                                    ),
                                    child: products[index].image != null
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(12),
                                            ),
                                            child: Image.network(
                                              products[index].image!,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                            ),
                                          )
                                        : Center(
                                            child: Icon(
                                              Icons.medication,
                                              size: 40,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        products[index].name!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "R\$ ${products[index].price!.toStringAsFixed(2)}",
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: products.length,
                    ),
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Carrinho'),
        icon: Icon(Icons.shopping_cart),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
