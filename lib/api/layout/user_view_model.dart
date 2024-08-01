import 'package:flutter/material.dart';
import 'package:gohealth/api/models/user_models.dart';
import 'package:gohealth/api/repositories/user_repository.dart';

class UserViewModel {
  final UserRepository repository;

  UserViewModel(this.repository);

  final userModels = ValueNotifier<UserModels>(UserModels());

  loadUserCredentials(
      TextEditingController email, TextEditingController password) async {
    userModels.value = await repository.authenticate(
      TextEditingController(),
      TextEditingController(),
    );
  }
}
