import 'package:flutter/material.dart';
import 'package:gohealth/api/models/pharmacy_model.dart';
import 'package:gohealth/api/repositories/pharmacy_repository.dart';

class PharmacyViewModel extends ValueNotifier<PharmacyModels> {
  late final PharmacyRepository repository;

  PharmacyViewModel(this.repository) : super(PharmacyModels());

  final pharmacyModels = ValueNotifier<PharmacyModels>(PharmacyModels());

  loadProducts() async {
    List<PharmacyModels> model = await repository.getAll();
    for (var item in model) {
      pharmacyModels.value = item;
    }
    return model;
  }

  getPharmacyById(int query) async {
    pharmacyModels.value = await repository.getPharmacyById(query);
  }

  void updatePharmacyData(pharmacyData) {}
}
