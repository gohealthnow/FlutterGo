import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gohealth/api/layout/user_view_model.dart';
import 'package:gohealth/api/repositories/user_repository.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  test('teste para saber se o nome é exibido no header com o nome do usuário',
      () async {
    final _repository = UserViewModel(UserRepository());

    expect(_repository.userModels.value.name, isNotNull);
    expect(_repository.userModels.value.email, isNotNull);
    expect(_repository.userModels.value.id, isNotNull);
  });
}
