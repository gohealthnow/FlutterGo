import 'package:flutter/material.dart';
import 'package:gohealth/api/layout/user_view_model.dart';
import 'package:gohealth/api/models/user_models.dart';

class LoginController {
  final UserViewModel _repository;

  LoginController(this._repository);

  ValueNotifier<UserModels> get userModels => _repository.userModels;

  void authenticate() {}
}