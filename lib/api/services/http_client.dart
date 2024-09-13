import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gohealth/api/models/product_models.dart';

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

  Future<Response> fetchWithRetry(String url,
      {int retries = 3, int delay = 1000}) async {
    int attempt = 0;
    while (attempt < retries) {
      try {
        final response = await Dio().get(url);
        return response;
      } on DioException catch (e) {
        if (e.response?.statusCode == 429) {
          attempt++;
          if (attempt >= retries) {
            rethrow;
          }
          await Future.delayed(Duration(milliseconds: delay * attempt));
        } else {
          rethrow;
        }
      }
    }
    throw Exception('Failed to fetch data after $retries attempts');
  }
}
