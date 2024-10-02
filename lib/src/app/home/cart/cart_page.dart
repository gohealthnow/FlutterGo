import 'package:flutter/material.dart';
import 'package:gohealth/api/models/product_models.dart';
import 'package:gohealth/api/repositories/user_repository.dart';
import 'package:gohealth/api/services/shared_local_storage_service.dart';
import 'package:gohealth/src/app/home/home_page.dart';
import 'package:gohealth/src/app/sessions/products/product_page.dart';
import 'package:gohealth/src/components/header_bar.dart';
import 'package:gohealth/src/components/side_menu.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  final _repository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBarState(),
      drawer: const SideMenu(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<ProductModels>>(
          future: SharedLocalStorageService().getAllProducts(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const SizedBox.shrink();
            } else {
              final total = snapshot.data!.fold<double>(
                0.0,
                (sum, item) => sum + (item.price ?? 0.0),
              );
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // await _repository.buy(SharedLocalStorageService().getAllProducts());
                      SharedLocalStorageService().clearCart();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Pedido finalizado com sucesso'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Homepage()));
                      setState(() {});
                    },
                    child: const Text(
                      'Finalizar Pedido',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      backgroundColor: Colors.green,
                    ),
                  ),
                  Text(
                    'Total: R\$${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }
          },
        ),
      ),
      body: FutureBuilder<List<ProductModels>>(
        future: SharedLocalStorageService().getAllProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum produto no carrinho'));
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
