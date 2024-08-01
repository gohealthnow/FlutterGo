import 'package:dio/dio.dart';
import 'package:gohealth/api/interfaces/client_http_interface.dart';

class ClientHttpService extends IClientHttp {
  final Dio dio = Dio();

  @override
  void addToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  @override
  Future<Map<String, dynamic>> get(String url) async {
    final response = await dio.get(url);
    return response.data;
  }
}
