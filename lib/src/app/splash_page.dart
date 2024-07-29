import 'package:flutter/material.dart';
import 'package:gohealth/src/app/home/home_page.dart';
import 'package:gohealth/src/app/login_page.dart';
import 'package:gohealth/src/database/repositories/user.repository.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    UserRepository.checkToken().then((value) {
      if (value) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const Homepage()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
