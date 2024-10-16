import 'package:flutter/material.dart';
import 'package:gohealth/api/models/user_models.dart';
import 'package:gohealth/api/repositories/user_repository.dart';
import 'package:gohealth/api/services/shared_local_storage_service.dart';
import 'package:gohealth/src/app/home/profile/forms/pharmacy_form_create.dart';
import 'package:gohealth/src/app/home/profile/forms/product_form_create.dart';
import 'package:gohealth/src/app/home/profile/forms/product_promotion_add.dart';
import 'package:gohealth/src/app/home/profile/forms/stock_update.dart';
import 'package:gohealth/src/app/home/profile/report/report_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _repositoryUser = UserRepository();

  final _sharedLocalStorageService = SharedLocalStorageService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<UserModels?>(
              future: _sharedLocalStorageService.getProfile(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Erro: ${snapshot.error}');
                } else {
                  if (snapshot.data != null) {
                    return Column(
                      children: [
                        Text('Nome: ${snapshot.data!.name}'),
                        Text('Email: ${snapshot.data!.email}'),
                        Divider(),
                        if (snapshot.data!.role == Role.ADMIN) ...[
                          Padding(
                              padding: EdgeInsets.all(12),
                              child: ProductForm()),
                          Divider(),
                          Padding(
                              padding: EdgeInsets.all(12),
                              child: PharmacyForm()),
                          Divider(),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: StockUpdate(),
                          ),
                          Divider(),
                          Padding(
                              padding: EdgeInsets.all(12),
                              child: ProductPromotionAdd()),
                          Divider(),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ReportPage()),
                                );
                              },
                              child: Text('Ir para Report Page'),
                            ),
                          ),
                        ]
                      ],
                    );
                  } else {
                    return const Text('Nenhum usuário encontrado');
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
