import 'package:flutter/material.dart';
import 'package:gohealth/api/interfaces/local_storage_interface.dart';

abstract class IUser extends ILocalStorage {
  Future<dynamic> authenticate(String email, String password);
  Future<dynamic> registerUser(String email, String name, String password);
  Future<bool> checkToken();
}
