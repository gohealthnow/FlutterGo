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
  final _searchController = TextEditingController();
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

  void _handleSearch(String value) {
    if (value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Digite algo para pesquisar'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (value.contains(RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]'))) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Caracteres especiais não são permitidos'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductsListPage(
          searchText: value,
        ),
      ),
    );
  }

  void _navigateToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.white,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF00A3FF),
              const Color(0xFF0072BB),
            ],
          ),
        ),
      ),
      elevation: 4,
      toolbarHeight: 85.0,
      title: SizedBox(
        height: 43,
        child: TextField(
          controller: _searchController,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Pesquisar produtos...',
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
          onSubmitted: _handleSearch,
        ),
      ),
      actions: [
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
                size: 28,
              ),
              onPressed: _navigateToCart,
            ),
            if (productLength != null && productLength!.isNotEmpty)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    productLength!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
        IconButton(
          icon: Icon(
            Icons.notifications_outlined,
            color: Colors.white,
            size: 28,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductReserve(userModels: profile!)),
            );
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
