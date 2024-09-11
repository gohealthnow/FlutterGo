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
            child: SizedBox(
              height: 43,
              child: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: TextField(
                  textAlignVertical: TextAlignVertical
                      .center, // Alinha o texto verticalmente ao centro
                  decoration: InputDecoration(
                    hintText: 'Pesquise aqui',
                    hintStyle: const TextStyle(
                        color: Colors.white), // Define a cor do texto do hint
                    prefixIcon: const Icon(Icons.search,
                        color: Colors.white), // Define a cor do ícone
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.white), // Define a cor da borda
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors
                              .white), // Define a cor da borda quando habilitado
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors
                              .white), // Define a cor da borda quando focado
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0), // Ajusta o preenchimento interno
                  ),
                  style: const TextStyle(
                      color: Colors.white), // Define a cor do texto
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(onPressed: () {
           // Função para carrinho
        }, icon: const Icon(Icons.shopping_cart)),
        IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Função para notificações
            },
          ),
      ],
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }
}
