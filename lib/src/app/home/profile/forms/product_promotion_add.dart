import 'package:flutter/material.dart';
import 'package:gohealth/api/models/product_models.dart';
import 'package:gohealth/api/repositories/product_repository.dart';

class ProductPromotionAdd extends StatefulWidget {
  const ProductPromotionAdd({Key? key}) : super(key: key);

  @override
  _ProductPromotionAddState createState() => _ProductPromotionAddState();
}

class _ProductPromotionAddState extends State<ProductPromotionAdd> {
  final _productController = TextEditingController();
  final _priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  ProductModels? selectedProduct;
  late List<ProductModels> products;

  @override
  void initState() {
    super.initState();
    products = [];
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // Executa operações assíncronas aqui
      List<ProductModels> loadedProducts = await ProductRepository().getAll();

      // Atualiza o estado de forma síncrona
      setState(() {
        products = loadedProducts;
      });
    } catch (e) {
      // Trata o erro
      print('Erro ao carregar os dados: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          DropdownButtonFormField<ProductModels>(
              decoration: InputDecoration(labelText: 'Selecionar Produto'),
              items: products.map((ProductModels product) {
                return DropdownMenuItem<ProductModels>(
                  value: product,
                  child: Text(product.name!),
                );
              }).toList(),
              onChanged: (ProductModels? newValue) {
                if (newValue == null) return;
                if (newValue.promotion == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Produto já possui uma promoção!'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
                setState(() {
                  selectedProduct = newValue;
                });
              },
              onSaved: (value) {
                selectedProduct = value;
              },
              validator: (value) {
                if (value == null) {
                  return 'Por favor, selecione um produto';
                }
                return null;
              }),
          TextFormField(
            controller: _productController,
            decoration: InputDecoration(labelText: 'Valor da Promoção'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira um valor';
              }
              if (double.tryParse(value) == null) {
                return 'Por favor, insira um valor válido';
              }
              return null;
            },
            onSaved: (value) {
              _priceController.text = value!;
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await ProductRepository()
                    .createProductPromotion(
                  product: selectedProduct!,
                )
                    .then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Promoção criada com sucesso!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erro ao criar a promoção!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                });
              }
            },
            child: Text('Criar Promoção'),
          ),
        ],
      ),
    );
  }
}
