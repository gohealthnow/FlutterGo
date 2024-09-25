import 'package:flutter/material.dart';
import 'package:gohealth/api/repositories/product_repository.dart';
import 'package:gohealth/src/app/sessions/products/product_page.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({ Key? key, required this.searchText}) : super(key: key);

  @override
  _ProductsListPageState createState() => _ProductsListPageState();

  final String searchText;
}

class _ProductsListPageState extends State<ProductsListPage> {

  final _repository = ProductRepository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _repository.getProducts(widget.searchText),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        } else {
          if (snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum produto encontrado'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].name!),
                  subtitle: Text(snapshot.data![index].description!),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductPage(
                          productModels: snapshot.data![index],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        }
      },
    );
  }
}