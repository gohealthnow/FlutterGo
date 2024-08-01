import 'package:flutter/material.dart';

class HeaderBar extends StatelessWidget implements PreferredSizeWidget {
  const HeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      toolbarHeight: 85.0,
      title: Row(
        children: <Widget>[
          const Expanded(
            child: Text(
              'Hello, João Augusto',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Função para notificações
            },
          ),
        ],
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
