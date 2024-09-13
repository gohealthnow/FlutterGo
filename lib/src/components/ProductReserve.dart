import 'package:flutter/material.dart';
import 'package:gohealth/api/models/product_models.dart';
import 'package:gohealth/api/models/user_models.dart';
import 'package:gohealth/api/repositories/product_repository.dart';
import 'package:gohealth/api/services/http_client.dart';
import 'package:gohealth/api/services/shared_local_storage_service.dart';
import 'package:gohealth/src/app/home/home_page.dart';
import 'package:gohealth/src/app/sessions/products/product_page.dart';
import 'package:gohealth/src/components/header_bar.dart';
import 'package:gohealth/src/components/side_menu.dart';

class ProductReserve extends StatefulWidget {
  const ProductReserve({Key? key, required this.userModels}) : super(key: key);

  @override
  _ProductReserveState createState() => _ProductReserveState();

  final UserModels userModels;
}

class _ProductReserveState extends State<ProductReserve> {
  final _repository = ProductRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBarState(),
      drawer: const SideMenu(),
      body: FutureBuilder<List<ProductModels>>(
        future: _repository.getProductsReserveList(widget.userModels.id!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum produto em reserva'));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductPage(productModels: snapshot.data![index]),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.all(10.0),
                    child: ListTile(
                      leading: Image.network(
                          product.image ?? "https://via.placeholder.com/150",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover),
                      title: Text(product.name!),
                      subtitle: Text(
                          'Preço: R\$${product.price!.toStringAsFixed(2)}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            snapshot.data!.removeAt(index);
                            SharedLocalStorageService()
                                .removeProduct(product.id);
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
