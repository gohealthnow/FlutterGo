import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({Key? key, productModels }) : super(key: key);

  @override
  State<ImageCarousel> createState() => ImageCarouselState();
}

class ImageCarouselState extends State<ImageCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Image.network(
              'https://via.placeholder.com/150'), // Substitua pelas imagens reais
          Image.network('https://via.placeholder.com/150'),
          Image.network('https://via.placeholder.com/150'),
        ],
      ),
    );
  }
}
