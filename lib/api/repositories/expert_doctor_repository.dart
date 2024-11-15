import 'package:gohealth/api/models/expert_doctor_models.dart';
import 'package:gohealth/api/services/http_client.dart';
import 'dart:async';


class ExpertDoctor {
  late MedicalExpertService userNetworkClient;

  ExpertDoctor() {
    userNetworkClient = MedicalExpertService();
  }

  // O expertDoctor é uma classe que irá representar a API da Inteligencia artificial que irá retornar os dados de cada função

  // ! Esta função recebe um prompt do usuário e a IA retorna um checklist de sintomas. O usuário deve marcar os sintomas que está sentindo, conforme o texto que ele escreveu e que gerou o checklist.

  Future<SymptomsDataRequest> getSymptoms(String prompt) async {
    var response = await userNetworkClient.client.post(
      '/symptoms',
      data: {
        'text': prompt,
      },
    ).timeout(Duration(seconds: 45));

    if (response.statusCode == 500) {
      throw Exception('Erro interno do servidor');
    }

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar os sintomas');
    }

    return SymptomsDataRequest.fromJson(response.data);
  }

  // ! Esta função irá enviar o checklist de sintomas marcados pelo usuário e a IA irá retornar um texto e uma descrição do que ele tem!
    Future<DiagnosticDataRequest> getDiagnosis(List<String> symptoms) async {
      var response = await userNetworkClient.client.post(
        '/diagnosis',
        data: {"sintomas": symptoms},
      ).timeout(Duration(seconds: 45));

      if (response.data == null) {
        throw Exception('Erro ao buscar o diagnóstico');
      }

      if (response.statusCode != 200) {
        throw Exception('Erro ao buscar o diagnóstico');
      }

      return DiagnosticDataRequest.fromJson(response.data);
  }
}