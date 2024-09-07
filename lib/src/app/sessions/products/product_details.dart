import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bershka Mom Jeans',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            '\$34',
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              ChoiceChip(
                label: Text('Blue'),
                selected: true,
                onSelected: (selected) {},
              ),
              SizedBox(width: 8),
              ChoiceChip(
                label: Text('Size'),
                selected: false,
                onSelected: (selected) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
