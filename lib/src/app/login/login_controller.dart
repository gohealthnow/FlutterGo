import 'package:flutter/material.dart';
import 'package:gohealth/api/layout/user_view_model.dart';
import 'package:gohealth/api/models/user_models.dart';

class LoginController {
  final UserViewModel _repository;

  LoginController(this._repository);

  ValueNotifier<UserModels> get userModels => _repository.userModels;

  Future<UserModels> login(
      TextEditingController email, TextEditingController password) async {
    await _repository.loadUserCredentials(email, password);
    return userModels.value;
  }
}
