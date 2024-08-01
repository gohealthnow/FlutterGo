abstract class IClientHttp {
  void addToken(String token);
  Future<Map<String, dynamic>> get(String url);
}
