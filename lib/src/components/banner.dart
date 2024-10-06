import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gohealth/api/layout/product_view_model.dart';
import 'package:gohealth/api/models/product_models.dart';
import 'package:gohealth/api/repositories/product_repository.dart';

import 'package:gohealth/src/app/sessions/products/product_page.dart';

class BannerComponent extends StatefulWidget {
  final bool hasPromotion;

  const BannerComponent({super.key, required this.hasPromotion});

  @override
  _BannerComponentState createState() => _BannerComponentState();
}

class _BannerComponentState extends State<BannerComponent> {
  final _repository = ProductRepository();
  final _viewModel = ProductsViewModel(ProductRepository());

  Future<List<ProductModels>>? products;

  @override
  void initState() {
    super.initState();
    products = _viewModel.loadProducts();
    if (widget.hasPromotion) {
      products = _viewModel.loadProducts().then((value) {
        return value.where((element) => element.promotion == true).toList();
      });
    } else {
      products = _viewModel.loadProducts().then((value) {
        return value.where((element) => element.promotion == false).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: FutureBuilder<List<ProductModels>>(
            future: products,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              } else {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('Nenhum produto encontrado.'));
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductPage(
                                      productModels: snapshot.data![index])),
                            );
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)],
                                radius: 50,
                                child: snapshot.data![index].image != null
                                    ? ClipOval(
                                        child: Image.network(
                                          snapshot.data![index].image!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Text(
                                        snapshot.data![index].name!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                              ),
                              Text(snapshot.data![index].name!),
                              const SizedBox(height: 5),
                              Text(
                                "R\$" + snapshot.data![index].price!.toString(),
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
                  );
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
