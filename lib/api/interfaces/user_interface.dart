import 'package:gohealth/api/models/user_models.dart';

abstract class IUser {
  Future<UserModels> login(String email, String password);
  Future<UserModels> registerUser(String email, String name, String password);
}
