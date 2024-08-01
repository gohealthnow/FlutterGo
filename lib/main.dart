import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gohealth/src/app/app_page.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const App());
}
