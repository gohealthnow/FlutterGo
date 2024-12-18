import 'package:flutter/material.dart';
import 'package:gohealth/api/models/product_models.dart';

class DescriptionWidget extends StatefulWidget {
  const DescriptionWidget({Key? key, required this.productModels})
      : super(key: key);

  @override
  State<DescriptionWidget> createState() => DescriptionSectionState();

  final ProductModels productModels;
}

class DescriptionSectionState extends State<DescriptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.productModels.description != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detalhe do Produto',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.productModels.description.toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                )
              : SizedBox.shrink(),
          widget.productModels.weight != null
              ? Text(
                  'Peso: ${widget.productModels.weight.toString()}g',
                  style: TextStyle(fontSize: 16),
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}
