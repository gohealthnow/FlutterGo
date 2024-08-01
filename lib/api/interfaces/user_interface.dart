import 'package:flutter/material.dart';
import 'package:gohealth/api/interfaces/local_storage_interface.dart';

abstract class IUser extends ILocalStorage {
  Future<dynamic> authenticate(
      TextEditingController email, TextEditingController password);
  Future<dynamic> registerUser(TextEditingController email,
      TextEditingController name, TextEditingController password);
  Future<bool> checkToken();
}
