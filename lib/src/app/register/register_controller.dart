import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gohealth/api/layout/user_view_model.dart';
import 'package:gohealth/api/models/user_models.dart';

class RegisterController {
  final UserViewModel _repository;

  RegisterController(this._repository);

  ValueNotifier<UserModels> get userModels => _repository.userModels;

  Future<UserModels> registerUser(
      String email, String name, String password) async {
    await _repository.registerUser(email, name, password);
    if (kDebugMode) {
      print(userModels.value.toJson());
    }
    return userModels.value;
  }

  void deleteToken() async {
    await _repository.logout();
  }
}
