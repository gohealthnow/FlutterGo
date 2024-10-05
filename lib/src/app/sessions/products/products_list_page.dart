import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gohealth/api/repositories/product_repository.dart';
import 'package:gohealth/src/app/home/home_page.dart';
import 'package:gohealth/src/app/sessions/products/product_page.dart';
import 'package:gohealth/src/components/header_bar.dart';
import 'package:gohealth/src/components/side_menu.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({Key? key, required this.searchText})
      : super(key: key);

  @override
  _ProductsListPageState createState() => _ProductsListPageState();

  final String searchText;
}

class _ProductsListPageState extends State<ProductsListPage> {
  final _repository = ProductRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const HeaderBarState(),
        drawer: const SideMenu(),
        body: FutureBuilder(
          future: _repository.getProducts(widget.searchText),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, color: Colors.red, size: 64),
                    SizedBox(height: 16),
                    Text(
                      'Erro: ${snapshot.error}',
                      style: TextStyle(fontSize: 18, color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Nenhum produto encontrado'),
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.orange,
                  ),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Homepage(),
                  ),
                );
              });
              return SizedBox.shrink();
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
                      child: ListTile(
                        leading: Image.network(
                          product.image ?? 'https://via.placeholder.com/150',
                          width: 50,
                        ),
                        title: Text(product.name!),
                        subtitle: Text('R\$ ${product.price.toString()}'),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
