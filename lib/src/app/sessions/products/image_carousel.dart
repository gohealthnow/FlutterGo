import 'package:flutter/material.dart';
import 'package:gohealth/api/models/product_models.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({Key? key, required this.productModels})
      : super(key: key);

  @override
  State<ImageCarousel> createState() => ImageCarouselState();

  final ProductModels productModels;
}

class ImageCarouselState extends State<ImageCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: Center(
          child: Image.network(
              widget.productModels.image ?? 'https://via.placeholder.com/150'),
        ));
  }
}
