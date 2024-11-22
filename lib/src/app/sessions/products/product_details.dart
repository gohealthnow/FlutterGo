import 'package:flutter/material.dart';
import 'package:gohealth/api/models/product_models.dart';
import 'dart:math' as math;

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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(
                  Icons.medication,
                  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(1.0),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "${widget.productModels.name!.split(" ").first}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Text(
            "${widget.productModels.name!.split(" ").skip(1).join(" ")}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
          ),
          if (widget.productModels.promotion != null &&
              widget.productModels.promotion!)
            Row(
              children: [
                Text(
                  "R\$${(widget.productModels.price! * 100 / 25)}",
                  style: TextStyle(
                      fontSize: 20,
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                      decorationColor: Colors.grey),
                ),
                const SizedBox(width: 8),
                Text(
                  "R\$${widget.productModels.price.toString()}",
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
              ],
            )
          else
            Text(
              "R\$${widget.productModels.price.toString()}",
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
          SizedBox(height: 16),
          widget.productModels.reviews != null &&
                  widget.productModels.reviews!.isNotEmpty
              ? Text(
                  'Avaliações',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              : SizedBox.shrink(),
          widget.productModels.reviews != null &&
                  widget.productModels.reviews!.isNotEmpty
              ? Column(
                  children: [
                    ...widget.productModels.reviews!.take(2).map((review) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize
                              .min, // Importante: não expande infinitamente
                          children: [
                            Text(
                              review.title.split(" ")[2],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(5, (index) {
                                return Icon(
                                  Icons.star,
                                  color:
                                      index < review.rating.clamp(0, 5).toInt()
                                          ? Colors.amber
                                          : Colors.grey,
                                  size: 15,
                                );
                              }),
                            ),
                            
                            const SizedBox(height: 8), // Espaçamento
                            Text(
                              review.body,
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(
                                height: 16), // Espaçamento entre reviews
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
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
