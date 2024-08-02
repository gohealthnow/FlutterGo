import 'package:flutter/material.dart';
import 'package:gohealth/api/layout/user_view_model.dart';
import 'package:gohealth/api/repositories/user_repository.dart';

class HeaderBarState extends StatefulWidget implements PreferredSizeWidget {
  const HeaderBarState({super.key});

  @override
  _HeaderBarState createState() => _HeaderBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HeaderBarState extends State<HeaderBarState> {
  final _repository = UserViewModel(UserRepository());

  String? name;

  @override
  void initState() {
    super.initState();
    _repository.addListener(_listener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      name = _repository.userModels.value.name!;
    });
  }

  void _listener() {
    setState(() {});
  }

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
  void dispose() {
    _repository.removeListener(_listener);
    super.dispose();
  }
}
