import 'package:gohealth/api/interfaces/local_storage_interface.dart';

abstract class IUser extends ILocalStorage {
  Future<bool> authenticate(String email, String password);
  Future<bool> registerUser(String email, String name, String password);
  Future<bool> checkToken();
}
