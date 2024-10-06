import 'package:flutter/material.dart';
import 'package:gohealth/api/models/pharmacy_model.dart';
import 'package:gohealth/api/models/product_models.dart';
import 'package:gohealth/api/repositories/pharmacy_repository.dart';
import 'package:gohealth/api/repositories/product_repository.dart';

class StockUpdate extends StatefulWidget {
  const StockUpdate({Key? key}) : super(key: key);

  @override
  _StockUpdateState createState() => _StockUpdateState();
}

class _StockUpdateState extends State<StockUpdate> {
  final _formKey = GlobalKey<FormState>();

  final _repositoryProduct = ProductRepository();
  final _repositoryPharmacy = PharmacyRepository();

  late List<PharmacyModels> pharmacies;
  late List<ProductModels> products;

  PharmacyModels? selectedPharmacy;
  ProductModels? selectedProduct;

  int quantity = 0;

  @override
  void initState() {
    super.initState();
    pharmacies = [];
    products = [];
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // Executa operações assíncronas aqui
      List<PharmacyModels> loadedPharmacies =
          await PharmacyRepository().getAll();
      List<ProductModels> loadedProducts = await ProductRepository().getAll();

      // Atualiza o estado de forma síncrona
      setState(() {
        pharmacies = loadedPharmacies;
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
          // Pharmacy selection
          DropdownButtonFormField<PharmacyModels>(
            decoration: InputDecoration(labelText: 'Selecionar Farmacia'),
            items: pharmacies.map((PharmacyModels pharmacy) {
              return DropdownMenuItem<PharmacyModels>(
                value: pharmacy,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(pharmacy.image!),
                ),
              );
            }).toList(),
            onChanged: (PharmacyModels? newValue) {
              setState(() {
                selectedPharmacy = newValue;
              });
            },
            onSaved: (value) {
              selectedPharmacy = value;
            },
            validator: (value) =>
                value == null ? 'Por favor selecionar uma farmacia' : null,
          ),
          // Product selection
          DropdownButtonFormField<ProductModels>(
            decoration: InputDecoration(labelText: 'Selecionar Produto'),
            items: products.map((ProductModels product) {
              return DropdownMenuItem<ProductModels>(
                value: product,
                child: Text(product.name!),
              );
            }).toList(),
            onChanged: (ProductModels? newValue) {
              setState(() {
                selectedProduct = newValue;
              });
            },
            onSaved: (value) {
              selectedProduct = value;
            },
            validator: (value) =>
                value == null ? 'Por favor, selecione um produto' : null,
          ),
          // Quantity input
          TextFormField(
            decoration: InputDecoration(labelText: 'Quantitade'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira uma quantidade';
              }
              if (int.tryParse(value) == null) {
                return 'Por favor, insira uma quantidade válida';
              }
              return null;
            },
            onSaved: (value) {
              quantity = int.parse(value!);
            },
          ),
          // Submit button
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                await _repositoryProduct
                    .updateStock(
                        pharmacy: selectedPharmacy!,
                        product: selectedProduct!,
                        quantity: quantity)
                    .then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Estoque atualizado com sucesso!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erro ao atualizar o estoque! $error'),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 15),
                    ),
                  );
                });
              }
            },
            child: Text('Atualizar estoque'),
          ),
        ],
      ),
    );
  }
}
