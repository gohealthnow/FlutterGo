import 'package:flutter/material.dart';
import 'package:gohealth/api/models/user_models.dart';
import 'package:gohealth/api/services/shared_local_storage_service.dart';
import 'package:gohealth/src/app/home/cart/cart_page.dart';
import 'package:gohealth/src/app/sessions/products/products_list_page.dart';
import 'package:gohealth/src/components/ProductReserve.dart';

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
  UserModels? profile;
  String? productLength;

  @override
  void initState() {
    super.initState();
    if (name != null) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = await _repository.getProfile();
      setState(() {
        name = user?.name ?? '';
        profile = user;
        productLength = user?.products?.length.toString() ?? '';
      });
    });
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
                  onSubmitted: (value) {
                    if (value.isEmpty) {
                      return;
                    }

                    if (value.length < 3) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Digite pelo menos 3 caracteres'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    if (value.contains(
                        RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]'))) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Caracteres especiais não são permitidos'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ProductsListPage(
                          searchText: value,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const CartPage()));
            },
            icon: const Icon(Icons.shopping_cart)),
        Stack(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ProductReserve(userModels: profile!),
                  ),
                );
              },
            ),
            Positioned(
              right: 0,
              child: Container(
                padding: EdgeInsets.all(0.7),
                decoration: (profile?.products == true)
                    ? BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      )
                    : null,
                constraints: BoxConstraints(
                  minWidth: 12,
                  minHeight: 12,
                ),
                child: Text(
                  productLength ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        )
      ],
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }
}
