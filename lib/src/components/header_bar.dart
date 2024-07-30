import 'package:flutter/material.dart';
import 'package:gohealth/src/database/repositories/user.repository.dart';

class HeaderBar extends StatelessWidget implements PreferredSizeWidget {
  final name =
      UserRepository.getUserProfile(UserRepository.getToken() as String);

  HeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      toolbarHeight: 85.0,
      title: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              'Hello, $name',
              style: const TextStyle(fontSize: 20, color: Colors.white),
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
  Size get preferredSize => throw UnimplementedError();
}
