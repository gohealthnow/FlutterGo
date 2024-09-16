import 'dart:async';
import 'dart:ui';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gohealth/api/repositories/pharmacy_repository.dart';
import 'package:gohealth/api/repositories/product_repository.dart';
import 'package:gohealth/api/services/shared_local_storage_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:gohealth/api/services/notification_client_service.dart';

void startBackgroundService() {
  final service = FlutterBackgroundService();
  service.startService();
}

void stopBackgroundService() {
  final service = FlutterBackgroundService();
  service.invoke("stop");
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
    androidConfiguration: AndroidConfiguration(
      autoStart: true,
      onStart: onStart,
      isForegroundMode: false,
      autoStartOnBoot: true,
    ),
  );
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final serverIP = dotenv.env['BASE_URL'] ?? "http://10.0.2.2:3000";

  final socket = io.io(serverIP, <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': true,
  });

  socket.onConnect((_) async {
    print('Connected. Socket ID: ${socket.id}');
    var user = await SharedLocalStorageService().getProfile();
    if (user != null && user.id != null) {
      socket.emit("id", user.id);
    } else {
      return;
    }
  });

  // Listener para o evento 'productAvailable'
  socket.on('productAvailable', (data) async {
    final product = await ProductRepository().getbyId(data['productId']);
    final pharmacy = await PharmacyRepository().getPharmacyById(data['pharmacyId']);
    print('Produto disponível: $data');

    // Enviar uma notificação para o usuário mesmo inativo ou ativo
    NotificationService.showNotification(
      0, // ID da notificação
      'Produto Disponível', // Título da notificação
      'Um novo produto está disponível: ${product.name} na farmácia ${pharmacy.name}', // Corpo da notificação
    );
  });

  socket.onDisconnect((_) {
    print('Disconnected');
  });

  socket.on("stock", (data) {
    print(data);
  });

  service.on("stop").listen((event) {
    service.stopSelf();
    print("background process is now stopped");
  });

  service.on("start").listen((event) {});
}
