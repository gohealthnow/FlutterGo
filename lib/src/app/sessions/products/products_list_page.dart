import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gohealth/api/models/product_models.dart';
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
            }

            // Handle error state
            if (snapshot.hasError) {
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
            }

            // Handle null or empty data
            if (!snapshot.hasData || snapshot.data == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info_outline, color: Colors.grey, size: 64),
                    SizedBox(height: 16),
                    Text(
                      'Nenhum produto encontrado',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            // Convert data to List if needed
            final products = snapshot.data as List<ProductModels>;

            if (products.isEmpty) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Nenhum produto disponível'),
                    duration: Duration(seconds: 2),
                  ),
                );
              });
              return Center(
                child: Text('Lista vazia'),
              );
            }

            // Return your list view with the products
            return Padding(
              padding: EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductPage(productModels: product),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              child: Hero(
                                tag: product.id!,
                                child: Image.network(
                                  product.image!,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.name!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'R\$ ${product.price!.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16,
                                        color: Colors.grey[400],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ));
  }
}
