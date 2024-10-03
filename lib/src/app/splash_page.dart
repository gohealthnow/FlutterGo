import 'package:flutter/material.dart';
import 'package:gohealth/api/layout/user_view_model.dart';
import 'package:gohealth/api/models/user_models.dart';
import 'package:gohealth/api/services/shared_local_storage_service.dart';
import 'package:gohealth/src/app/home/home_page.dart';
import 'package:gohealth/src/app/login/login_page.dart';
import 'package:gohealth/api/repositories/user_repository.dart';
import 'package:gohealth/src/app/sessions/first_session.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    UserViewModel userRepository = UserViewModel(UserRepository());

    UserModels? profile = await SharedLocalStorageService().getProfile();
    int? id = profile?.id;

    bool isLogged = await userRepository.repository
        .checkToken()
        .timeout(const Duration(seconds: 0), onTimeout: () => false);

    bool isFirstSession =
        await userRepository.repository.doesUserHaveProduct(id);

    Future.delayed(const Duration(seconds: 0), () {
      if (isLogged) {
        if (isFirstSession) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FirstSessionPage(),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Homepage(),
            ),
          );
        }
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
