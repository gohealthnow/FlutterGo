import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gohealth/api/interfaces/user_interface.dart';
import 'package:gohealth/api/services/http_client.dart';

class expertDoctor {
  late MedicalExpertService userNetworkClient;

  expertDoctor() {
    userNetworkClient = MedicalExpertService();
  }

  // O expertDoctor é uma classe que irá representar a API da Inteligencia artificial que irá retornar os dados de cada função

  // ! Esta função recebe um prompt do usuário e a IA retorna um checklist de sintomas. O usuário deve marcar os sintomas que está sentindo, conforme o texto que ele escreveu e que gerou o checklist.
  Future<Response> getChecklist(String prompt) async {
    try {
      return await userNetworkClient.client.post(
        '/checklist',
        data: {
          'prompt': prompt,
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
