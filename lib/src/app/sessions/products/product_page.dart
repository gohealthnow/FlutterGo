import 'package:flutter/material.dart';
import 'package:gohealth/api/models/product_models.dart';
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
            onPressed: () {},
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
            // Salvar os dados do produto no carrinho atráves do storage
            SharedLocalStorageService().saveProduct(widget.productModels);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Produto adicionado ao carrinho'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
            Navigator.pop(context);
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
