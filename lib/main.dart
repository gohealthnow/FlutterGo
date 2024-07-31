import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gohealth/src/app/splash_page.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GoHealth',
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 0, 91, 226),
          fontFamily: 'Rubik',
        ),
        home: const SplashPage());
  }
}
