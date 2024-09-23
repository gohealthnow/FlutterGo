import 'package:flutter/widgets.dart';
import 'package:gohealth/api/repositories/product_repository.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({ Key? key, required this.searchText}) : super(key: key);

  @override
  _ProductsListPageState createState() => _ProductsListPageState();

  final String searchText;
}

class _ProductsListPageState extends State<ProductsListPage> {

  final _repository = ProductRepository();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}