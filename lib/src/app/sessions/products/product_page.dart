import 'package:flutter/material.dart';
import 'package:gohealth/api/models/product_models.dart';
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
            ImageCarousel(), // ! productModels: widget.productModels
            ProductDetails(), // ! productModels: widget.productModels
            DescriptionSection(), // ! productModels: widget.productModels
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Add to cart'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }
}
