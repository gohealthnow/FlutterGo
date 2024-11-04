import 'package:dio/dio.dart';
import 'package:gohealth/api/services/http_client.dart';

class expertDoctor {
  late MedicalExpertService userNetworkClient;

  expertDoctor() {
    userNetworkClient = MedicalExpertService();
  }

  // O expertDoctor é uma classe que irá representar a API da Inteligencia artificial que irá retornar os dados de cada função

  // ! Esta função recebe um prompt do usuário e a IA retorna um checklist de sintomas. O usuário deve marcar os sintomas que está sentindo, conforme o texto que ele escreveu e que gerou o checklist.
  Future<Response> getSymptoms(String prompt) async {
    try {
      return await userNetworkClient.client.post(
        '/symptoms',
        data: {
          'prompt': prompt,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  // ! Esta função irá enviar o checklist de sintomas marcados pelo usuário e a IA irá retornar um texto e uma descrição do que ele tem!
  Future<Response> getDiagnosis(Map<String, dynamic> symptoms) async {
    try {
      return await userNetworkClient.client.post(
        '/diagnosis',
        data: symptoms,
      );
    } catch (e) {
      rethrow;
    }
  }
}
