import 'package:flutter/material.dart';

class ButtonField extends StatelessWidget {
  final String textButton;

  const ButtonField({
    super.key,
    required this.textButton,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
            const Color.fromARGB(255, 0, 91, 226)), // Cor de fundo
        foregroundColor:
            WidgetStateProperty.all<Color>(Colors.white), // Cor do texto
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Bordas arredondadas
          ),
        ),
        elevation: WidgetStateProperty.all<double>(5.0), // Sombra
        padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(
              horizontal: 130.0, vertical: 15.0), // Tamanho do botão
        ),
      ),
      onPressed: () {
        // Implementar ação de login
      },
      child: Text(
        textButton,
        style: const TextStyle(
          fontSize: 18.0, // Tamanho do texto
          fontWeight: FontWeight.w900, // Deixa o texto em negrito
        ),
      ),
    );
  }
}
