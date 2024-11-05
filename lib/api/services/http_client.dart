import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HttpClient {
  late Dio client;

  HttpClient() {
    client = Dio(BaseOptions(
      baseUrl: dotenv.env['BASE_URL'] ?? 'http://10.0.2.2:3000',
      headers: {
        'Content-Type': 'application/json',
      },
    ));
  }

}


class MedicalExpertService {
  late Dio client;

  HttpClient() {
    client = Dio(BaseOptions(
      baseUrl: dotenv.env['BASE_URL_IA'] ?? 'http://127.0.0.1:8000',
      headers: {
        'Content-Type': 'application/json',
      },
    ));
  }
}
