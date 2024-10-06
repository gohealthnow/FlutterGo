import 'package:flutter/material.dart';
import 'package:gohealth/api/models/pharmacy_model.dart';
import 'package:gohealth/api/repositories/pharmacy_repository.dart';

class PharmacyForm extends StatefulWidget {
  @override
  _PharmacyFormState createState() => _PharmacyFormState();
}

class _PharmacyFormState extends State<PharmacyForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cepController = TextEditingController();
  final _emailController = TextEditingController();
  final _imageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _repository = PharmacyRepository();

  @override
  void dispose() {
    _nameController.dispose();
    _cepController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final pharmacy = PharmacyModels(
        name: _nameController.text,
        email: _emailController.text,
        image: _imageController.text,
        phone: _phoneController.text,
      );

      await _repository
          .createPharmacy(
        name: pharmacy.name!,
        cep: _cepController.text,
        email: pharmacy.email!,
        image: pharmacy.image!,
        phone: pharmacy.phone!,
      )
          .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Farmacia criado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao criar a farmacia! $error'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 15),
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
          Text('Criar Farmacia',
              style: Theme.of(context).textTheme.headlineMedium),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Nome da Farmacia'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira o nome da farmacia';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _cepController,
            decoration: InputDecoration(labelText: 'CEP'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira o CEP';
              }
              if (value.length != 8 && value.length != 9) {
                return 'CEP inválido. Deve ter 8 ou 9 caracteres';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira o email';
              }
              if (!RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value)) {
                return 'Email inválido, digite corretamente';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _imageController,
            decoration: InputDecoration(labelText: 'Imagem'),
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                if (!Uri.parse(value).isAbsolute) {
                  return 'Por favor, insira um link válido';
                }
              }
              return null;
            },
          ),
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(labelText: 'Telefone'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira o telefone';
              }
              if (value.length < 10 || value.length > 11) {
                return 'Telefone inválido';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text('Criar Farmacia'),
          ),
        ],
      ),
    );
  }
}
