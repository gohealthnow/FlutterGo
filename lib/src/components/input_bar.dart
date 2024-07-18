import 'package:flutter/material.dart';

class InputBar extends StatefulWidget {
  final IconData icon;

  const InputBar({super.key, required this.icon});

  @override
  _InputBarState createState() => _InputBarState();
}

class _InputBarState extends State<InputBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: 'Digite algo...',
        prefixIcon: IconButton(
          icon: Icon(widget.icon),
          onPressed: () {
            String inputText = _controller.text;
            print('Texto digitado: $inputText');
            _controller.clear();
          },
        ),
      ),
    );
  }
}
