import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gohealth/api/services/shared_local_storage_service.dart';

class HeaderBarState extends StatefulWidget implements PreferredSizeWidget {
  const HeaderBarState({super.key});

  @override
  _HeaderBarState createState() => _HeaderBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HeaderBarState extends State<HeaderBarState> {
  final _repository = SharedLocalStorageService();

  String? name;

  @override
  void initState() {
    super.initState();
    if (name != null) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = await _repository.getProfile();
      setState(() {
        name = user?.name;
      });
    });
    if (kDebugMode) {
      print(name);
    }
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
              name != null ? 'Olá, $name' : 'null',
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
}
