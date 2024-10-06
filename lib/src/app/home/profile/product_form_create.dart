import 'package:flutter/material.dart';
import 'package:gohealth/api/models/product_models.dart';
import 'package:gohealth/api/repositories/product_repository.dart';

class ProductForm extends StatefulWidget {
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _repository = ProductRepository();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final product = ProductModels(
        name: _nameController.text,
        price: double.parse(_priceController.text),
      );

      await _repository.createProduct(product).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Produto criado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao criar o produto!'),
            backgroundColor: Colors.red,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text('Criar Produto',
              style: Theme.of(context).textTheme.headlineMedium),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Nome do Produto'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira o nome do produto';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _priceController,
            decoration: InputDecoration(labelText: 'Preço do Produto'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira o preço do produto';
              }
              value = value.replaceAll(',', '.');
              if (double.tryParse(value) == null) {
                return 'Por favor, insira um preço válido';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text('Criar Produto'),
          ),
        ],
      ),
    );
  }
}
