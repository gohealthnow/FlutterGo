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
          Text(
            'Avaliações',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          widget.productModels.reviews != null &&
                  widget.productModels.reviews!.isNotEmpty
              ? Column(
                  children: [
                    ...widget.productModels.reviews!.take(2).map((review) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                review.title,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.star, color: Colors.yellow),
                            Row(
                              children:
                                  List.generate(review.rating.toInt(), (index) {
                                return Icon(Icons.star, color: Colors.yellow);
                              }),
                            ),
                            Expanded(
                                child: Text(
                              review.body,
                              style: TextStyle(fontSize: 16),
                            ))
                          ],
                        ),
                      );
                    }).toList(),
                    if (widget.productModels.reviews!.length > 2)
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Todas as Avaliações'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: widget.productModels.reviews!
                                        .map((review) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              review.title,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 4),
                                            Row(
                                              children: List.generate(
                                                  review.rating.toInt(),
                                                  (index) {
                                                return Icon(Icons.star,
                                                    color: Colors.yellow);
                                              }),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              review.body,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Divider(),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: Text('Fechar'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('Ver mais'),
                      ),
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
