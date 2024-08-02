import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gohealth/api/layout/user_view_model.dart';
import 'package:gohealth/api/models/user_models.dart';
import 'package:gohealth/api/repositories/user_repository.dart';
import 'package:gohealth/src/app/login/login_controller.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  final repository = UserViewModel(UserRepository());
  var controller = LoginController(repository);

  test(
      'Teste apenas para saber se o login está funcionando como o UserViewModel',
      () async {
    UserModels user = await controller.login('joaoaugusto@gmail.com', '123456');

    if (kDebugMode) {
      print(user.toJson());
    }
    expect(user.email, 'joaoaugusto@gmail.com');
  });
}
