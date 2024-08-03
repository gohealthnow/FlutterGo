import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gohealth/api/layout/user_view_model.dart';
import 'package:gohealth/api/repositories/user_repository.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  test('teste para saber se o nome é exibido no header com o nome do usuário',
      () async {
    final repository = UserViewModel(UserRepository());

    expect(repository.userModels.value.name, isNotNull);
    expect(repository.userModels.value.email, isNotNull);
    expect(repository.userModels.value.id, isNotNull);
  });
}
