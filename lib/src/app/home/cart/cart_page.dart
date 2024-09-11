import 'package:flutter/material.dart';
import 'package:gohealth/api/models/product_models.dart';
import 'package:gohealth/api/services/shared_local_storage_service.dart';
import 'package:gohealth/src/components/header_bar.dart';
import 'package:gohealth/src/components/side_menu.dart';

class CartPage extends StatefulWidget {
  const CartPage({ Key? key }) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBarState(),
      drawer: const SideMenu(),
      body: FutureBuilder<List<ProductModels>>(
        future: SharedLocalStorageService().getAllProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No items selected.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: Image.network(product.image ?? "https://via.placeholder.com/150", width: 50, height: 50, fit: BoxFit.cover),
                    title: Text(product.name!),
                    subtitle: Text('Price: \$${product.price!.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          snapshot.data!.removeAt(index);
                          SharedLocalStorageService().removeProduct(product.id);
                        });
                      },
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