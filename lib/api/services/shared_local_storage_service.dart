import 'package:gohealth/api/interfaces/local_storage_interface.dart';
import 'package:gohealth/api/models/user_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedLocalStorageService implements ILocalStorage {
  @override
  Future delete(String key) async {
    var shared = await SharedPreferences.getInstance();
    return shared.remove(key);
  }

  Future<UserModels?> getProfile() async {
    var shared = await SharedPreferences.getInstance();
    var user = UserModels(
      id: shared.getInt('id'),
      createdAt: shared.getString('createdAt'),
      updatedAt: shared.getString('updatedAt'),
      email: shared.getString('email'),
      name: shared.getString('name'),
      avatar: shared.getString('avatar'),
      bio: shared.getString('bio'),
      role: shared.getString('role'),
    );

    return user;
  }

  Future<UserModels> putProfile(UserModels user) async {
    var shared = await SharedPreferences.getInstance();

    for (var key in user.toJson().keys) {
      if (key == 'id') {
        shared.setInt(key, user.toJson()[key] as int);
        continue;
      }
      shared.setString(key, user.toJson()[key].toString());
    }

    return user;
  }

  @override
  Future<String?> get(String key) async {
    var shared = await SharedPreferences.getInstance();
    return shared.getString(key);
  }

  @override
  Future put(String key, dynamic value) async {
    var shared = await SharedPreferences.getInstance();
    if (value is bool) {
      shared.setBool(key, value);
    } else if (value is String) {
      shared.setString(key, value);
    } else if (value is int) {
      shared.setInt(key, value);
    } else if (value is double) {
      shared.setDouble(key, value);
    } else if (value is UserModels) {
      shared.setString(key, value.toJson().toString());
    }
  }

  void clearProfile() {
    var shared = SharedPreferences.getInstance();
    shared.then((value) {
      value.clear();
    });
  }
}
