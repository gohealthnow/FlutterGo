import 'package:flutter/material.dart';
import 'package:gohealth/api/models/product_models.dart';
import 'package:gohealth/api/repositories/user_repository.dart';
import 'package:gohealth/api/services/shared_local_storage_service.dart';
import 'package:gohealth/src/app/home/home_page.dart';

class ReviewAdd extends StatefulWidget {
  final ProductModels productModels;

  const ReviewAdd({Key? key, required this.productModels}) : super(key: key);

  @override
  _ReviewAddState createState() => _ReviewAddState();
}

class _ReviewAddState extends State<ReviewAdd> {
  final _formKey = GlobalKey<FormState>();

  final _sharedPreferences = SharedLocalStorageService();

  final _repositoryUser = UserRepository();
  final _textController = TextEditingController();

  late var _star = 0;

  Future<bool> userHasBought() async {
    var user = await _sharedPreferences.getProfile();
    // Verifica se o usuario comprou o produto
    final orders = await _repositoryUser.getOrder(user: user!);

    for (var order in orders) {
      if (order.productId == widget.productModels.id) {
        return true;
      }
    }
    return false;
  }

  setStar(int star) {
    setState(() {
      _star = star;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userHasBought(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        } else {
          if (snapshot.hasData) {
            return Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _textController,
                        decoration: const InputDecoration(
                          labelText: 'Avaliação',
                        ),
                        maxLines: null,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira uma avaliação';
                          }
                          if (value.length < 5) {
                            return 'A avaliação deve ter no minimo 5 caracteres';
                          }
                          if (value.length > 200) {
                            return 'A avaliação deve ter no máximo 200 caracteres';
                          }
                          return null;
                        },
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            for (var i = 1; i <= 5; i++)
                              IconButton(
                                icon: Icon(
                                  Icons.star,
                                  color:
                                      i <= _star ? Colors.amber : Colors.grey,
                                  size: 30,
                                ),
                                onPressed: () {
                                  setStar(i);
                                },
                              ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            var user = await _sharedPreferences.getProfile();
                            
                            await _repositoryUser
                                .createReview(
                              user: user!.id!,
                              product: widget.productModels.id!,
                              rating: _star,
                              review: _textController.text,
                            )
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Avaliação enviada com sucesso!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Homepage();
                              }));
                            }).catchError((error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Erro ao enviar a avaliação!'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            });
                          }
                        },
                        child: const Text('Enviar'),
                      ),
                    ],
                  ),
                ));
          } else {
            return const Text('Você precisa comprar o produto para avaliar');
          }
        }
      },
    );
  }
}
