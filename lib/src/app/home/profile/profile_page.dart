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
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              // Foto de perfil
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: snapshot.data?.avatar != null
                                    ? NetworkImage(snapshot.data!.avatar!)
                                    : const NetworkImage(
                                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                              ),
                              const SizedBox(height: 24),

                              // Informações do usuário
                              Card(
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!.name!.split(" ")[0],
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "E-mail",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.email!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Bio",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.bio!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Role",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.role.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(
                                height: 32,
                                thickness: 1,
                              ),
                            ],
                          ),
                        ),
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
