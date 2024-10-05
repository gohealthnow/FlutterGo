import 'package:flutter/material.dart';
import 'package:gohealth/api/models/pharmacy_model.dart';
import 'package:gohealth/api/models/product_models.dart';
import 'package:gohealth/api/repositories/pharmacy_repository.dart';
import 'package:gohealth/api/services/shared_local_storage_service.dart';
import 'image_carousel.dart';
import 'product_details.dart';
import 'description_section.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.productModels}) : super(key: key);

  @override
  State<ProductPage> createState() => ProductState();

  final ProductModels productModels;
}

class ProductState extends State<ProductPage> {
  final _repository = PharmacyRepository();

  List<PharmacyModels> pharmacies = [];

  Future<List<PharmacyModels>> _fetchPharmacies() async {
    pharmacies.clear();
    for (var i in widget.productModels.pharmacyProduct!) {
      PharmacyModels pharmacy =
          await _repository.getPharmacyById(i.pharmacyId!);
      pharmacies.add(pharmacy);
    }
    return pharmacies;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produto'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Ação de criar uma avaliação
              
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageCarousel(productModels: widget.productModels),
            ProductDetailsPage(productModels: widget.productModels),
            DescriptionWidget(productModels: widget.productModels),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return FutureBuilder<List<PharmacyModels>>(
                  future: _fetchPharmacies(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return AlertDialog(
                        title: Text('Erro'),
                        content: Text(
                            'Erro ao carregar farmácias: ${snapshot.error}'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Fechar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    } else {
                      return AlertDialog(
                        title: Text('Escolha uma farmácia'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: snapshot.data!.map((pharmacy) {
                              return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(pharmacy
                                        .image!), // Supondo que a URL da foto esteja em pharmacy.photoUrl
                                    backgroundColor: Colors.transparent,
                                  ),
                                  title: Text(
                                    pharmacy.name!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text('Telefone: ${pharmacy.phone}'),
                                  onTap: () async {
                                    // Ação ao selecionar a farmácia
                                    Navigator.of(context).pop();

                                    try {
                                      SharedLocalStorageService()
                                          .addProductToCart(
                                            product: widget.productModels,
                                            pharmacy: pharmacy,
                                            quantity: 1,
                                          )
                                          .toString();

                                      final product = widget.productModels.name;

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              '$product adicionado ao carrinho'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Erro ao adicionar ao carrinho: $e'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  });
                            }).toList(),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancelar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    }
                  },
                );
              },
            );
          },
          child: Text('Adicionar ao carrinho'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }
}
