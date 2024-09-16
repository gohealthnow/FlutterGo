import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gohealth/api/services/notification_client_service.dart';
import 'package:gohealth/src/app/app_page.dart';
import 'package:gohealth/api/services/socket_client_service.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  NotificationService.initialize();
  await initializeService();
  runApp(const App());
}
