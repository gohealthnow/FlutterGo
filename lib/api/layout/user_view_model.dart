import 'package:flutter/material.dart';
import 'package:gohealth/api/models/user_models.dart';
import 'package:gohealth/api/repositories/user_repository.dart';
import 'package:gohealth/api/services/shared_local_storage_service.dart';

class UserViewModel extends ValueNotifier<UserModels> {
  final UserRepository repository;

  UserViewModel(this.repository) : super(UserModels());

  final userModels = ValueNotifier<UserModels>(UserModels());

  loadUserCredentials(String email, String password) async {
    userModels.value = await repository.login(
      email,
      password,
    );
  }

  Future<UserModels> registerUser(
      String email, String name, String password) async {
    await repository.registerUser(email, name, password);
    return UserModels();
  }

  logout() async {
    SharedLocalStorageService().delete('token');
    userModels.value = UserModels();
  }
}
