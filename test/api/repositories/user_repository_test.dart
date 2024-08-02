import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gohealth/api/models/user_models.dart';
import 'package:gohealth/api/repositories/user_repository.dart';

void main() {
  test('capturar os valores dentro do usuario', () async {
    final repository = UserRepository();
    final user =
        await repository.authenticate('joaoaugusto@gmail.com', '123456');

    print(user.toJson());

    expect(user, isA<UserModels>());
  });
}
