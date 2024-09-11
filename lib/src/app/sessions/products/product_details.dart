import 'package:flutter/material.dart';
import 'package:gohealth/api/models/product_models.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({Key? key, required this.productModels})
      : super(key: key);

  @override
  State<ProductDetailsPage> createState() => ProductDetails();

  final ProductModels productModels;
}


class ProductDetails extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.productModels.name ?? 'Nome não disponível',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            "R\$${widget.productModels.price.toString()}",
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
