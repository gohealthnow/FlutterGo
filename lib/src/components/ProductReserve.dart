import 'package:flutter/material.dart';
import 'package:gohealth/api/models/product_models.dart';
import 'package:gohealth/api/models/user_models.dart';
import 'package:gohealth/api/repositories/product_repository.dart';
import 'package:gohealth/api/repositories/user_repository.dart';
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

  final _repositoryUser = UserRepository();

  Future<List<ProductModels>>? products;

  @override
  void initState() {
    super.initState();
    products = _repository.getProductsByUser(widget.userModels.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBarState(),
      drawer: const SideMenu(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductScreen(
                userId: widget.userModels.id!,
                onProductAdded: () {
                  setState(() {
                    // Refresh products list
                    products =
                        _repository.getProductsByUser(widget.userModels.id!);
                  });
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<ProductModels>>(
        future: products,
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
                          });
                          _repositoryUser.unlinkProductinUser(
                              product, widget.userModels.id!);
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

class AddProductScreen extends StatefulWidget {
  final int userId;
  final VoidCallback onProductAdded;

  const AddProductScreen({
    Key? key,
    required this.userId,
    required this.onProductAdded,
  }) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final ProductRepository _repository = ProductRepository();
  final UserRepository _userRepository = UserRepository();
  Future<List<ProductModels>>? _availableProducts;

  @override
  void initState() {
    super.initState();
    _availableProducts = _repository.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Produto'),
      ),
      body: FutureBuilder<List<ProductModels>>(
        future: _availableProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum produto disponível'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final product = snapshot.data![index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  leading: Image.network(
                    product.image ?? "https://via.placeholder.com/150",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.name!),
                  subtitle: Text('R\$ ${product.price!.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () async {
                      try {
                        _userRepository.linkProductinUser(
                          product,
                          widget.userId,
                        );
                        widget.onProductAdded();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Produto adicionado com sucesso!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Erro ao adicionar produto'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
