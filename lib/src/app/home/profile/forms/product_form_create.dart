import 'package:flutter/material.dart';
import 'package:gohealth/api/models/product_models.dart';
import 'package:gohealth/api/repositories/product_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProductForm extends StatefulWidget {
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  XFile? Imagem;
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
        image: Imagem != null ? await saveImage() : null,
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

  Future<String> saveImage() async {
    final String path = 'images/${DateTime.now()}.png';
    final File file = File(Imagem!.path);
    await file.copy(path);
    return path;
  }

  selecionarImagem() async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? imagemSelecionada = await picker.pickImage(
        source: ImageSource.gallery,
      );

      if (imagemSelecionada != null) {
        setState(() {
          Imagem = imagemSelecionada;
        });
      }

    } catch (e) {
      print(e);
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
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Preço do Produto'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o preço do produto';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Por favor, insira um preço válido';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  selecionarImagem();
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Imagem != null
                      ? Image.file(
                          File(Imagem!.path),
                          fit: BoxFit.cover,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                            Text(
                              'Selecionar Imagem',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10, height: 2),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Descrição do Produto'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira a descrição do produto';
              }
              return null;
            },
            maxLines: 3,
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
