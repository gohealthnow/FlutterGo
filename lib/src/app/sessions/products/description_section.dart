import 'package:flutter/material.dart';

class DescriptionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'These are the Mom Jeans you\'ve been looking for. Let loose with this modern interpretation of a classic \'90s style, featuring a flattering high rise and stacked, tapered leg. These jeans are designed to be worn as a relaxed, loose style.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Text('- Waist-emphasizing high rise'),
        ],
      ),
    );
  }
}
