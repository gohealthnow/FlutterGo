import 'package:flutter/material.dart';
import 'package:gohealth/src/app/home/side_menu.dart';

class HeaderBar extends StatelessWidget implements PreferredSizeWidget {
  const HeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Row(
        children: <Widget>[
          const Expanded(
            child: Text(
              'Olá, Gabriel Oliveira',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Função para notificações
            },
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
