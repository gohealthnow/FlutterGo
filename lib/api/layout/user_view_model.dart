import 'package:flutter/material.dart';
import 'package:gohealth/api/models/user_models.dart';
import 'package:gohealth/api/repositories/user_repository.dart';
import 'package:gohealth/api/services/shared_local_storage_service.dart';

class UserViewModel extends ValueNotifier<UserModels> {
  final UserRepository repository;

  UserViewModel(this.repository) : super(UserModels());

  final userModels = ValueNotifier<UserModels>(UserModels());

  loadUserCredentials(String email, String password) async {
    userModels.value = await repository.authenticate(
      email,
      password,
    );
  }

  registerUser(String email, String name, String password) async {
    await repository.registerUser(email, name, password);
  }

  getProfile() async {
    userModels.value = await repository.get('profile');
  }

  logout() async {
    SharedLocalStorageService().delete('token');
    userModels.value = UserModels();
  }
}
