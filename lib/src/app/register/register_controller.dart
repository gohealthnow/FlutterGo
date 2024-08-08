import 'package:gohealth/api/layout/user_view_model.dart';
import 'package:gohealth/api/models/user_models.dart';

class RegisterController {
  final UserViewModel _repository;

  RegisterController(this._repository);

  Future<UserModels> registerUser(
      String name, String email, String password) async {
    await _repository.registerUser(name, email, password);
    return _repository.userModels.value;
  }
}
