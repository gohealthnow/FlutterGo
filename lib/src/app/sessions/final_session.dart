import 'package:flutter/material.dart';
import 'package:gohealth/api/layout/product_view_model.dart';
import 'package:gohealth/api/models/product_models.dart';
import 'package:gohealth/api/repositories/product_repository.dart';
import 'package:gohealth/api/services/shared_local_storage_service.dart';
import 'package:gohealth/src/app/home/home_page.dart';
import 'package:gohealth/src/app/sessions/second_session.dart';

class FinalSessionPage extends StatefulWidget {
  const FinalSessionPage({super.key});

  @override
  State<FinalSessionPage> createState() => FinalSessionState();
}

class FinalSessionState extends State<FinalSessionPage> {
  final _repository = ProductRepository();

  final _repositoryUser = SharedLocalStorageService();

  int? _id;

  final _viewModel = ProductsViewModel(ProductRepository());

  var products = <ProductModels>[];

  var itemSelected = <ProductModels>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = await _repositoryUser.getProfile();
      _viewModel.loadProducts().then((products) {
        setState(() {
          _id = user?.id;
          this.products = products;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SecondSessionPage()));
            },
            style: TextButton.styleFrom(
              foregroundColor:
                  const Color.fromRGBO(0, 90, 226, 0.85), // Cor do texto
            ),
            child: const Text('Anterior'),
          ),
          Row(
            children: [
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(50)),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(50)),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: BorderRadius.circular(50)),
              )
            ],
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FinalSessionPage()));
            },
            style: TextButton.styleFrom(
              foregroundColor:
                  const Color.fromRGBO(0, 90, 226, 0.85), // Cor do texto
            ),
            child: const Text('Próximo'),
          ),
        ],
      ),
      body: Form(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              const Text('Sua primeira consulta'),
              Image.asset('assets/images/Final_Session.png'),
              ListView.builder(
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(products[index].name!),
                    value: itemSelected.contains(products[index]),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          itemSelected.add(products[index]);
                        } else {
                          itemSelected.remove(products[index]);
                        }
                      });
                    },
                  );
                },
              ),
              ElevatedButton(
                  onPressed: () => {
                        for (var item in itemSelected)
                          {_viewModel.addProductInUser(item, _id!)},
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Homepage()))
                      },
                  child: const Text('Finalizar sessão')),
            ],
          ),
        ),
      ),
    );
  }
}
