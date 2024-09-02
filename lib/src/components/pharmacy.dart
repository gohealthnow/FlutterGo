import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gohealth/api/layout/pharmacy_view_model.dart';
import 'package:gohealth/api/models/pharmacy_model.dart';
import 'package:gohealth/api/repositories/pharmacy_repository.dart';

class PharmacyComponentState extends StatefulWidget {
  const PharmacyComponentState({super.key});

  @override
  State<PharmacyComponentState> createState() => PharmacyComponent();
}

class PharmacyComponent extends State<PharmacyComponentState> {
  final _repository = PharmacyRepository();
  final _viewModel = PharmacyViewModel(PharmacyRepository());

  Future<List<PharmacyModels>>? pharmacies;

  @override
  void initState() {
    super.initState();
    pharmacies = _viewModel.loadPharmacies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: FutureBuilder<List<PharmacyModels>>(
            future: pharmacies,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              } else {
                if (snapshot.data!.isEmpty) {
                  return Container();
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.primaries[
                                  Random().nextInt(Colors.primaries.length)],
                              radius: 50,
                              child: Text(
                                snapshot.data![index].name!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
