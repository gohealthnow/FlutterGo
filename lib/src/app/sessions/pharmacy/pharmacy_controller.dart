import 'package:flutter/foundation.dart';
import 'package:gohealth/api/layout/pharmacy_view_model.dart';
import 'package:gohealth/api/models/pharmacy_model.dart';
import 'package:gohealth/api/repositories/pharmacy_repository.dart';

class PharmacyPageController {
  final PharmacyViewModel viewModel = PharmacyViewModel(PharmacyRepository());

  Future<PharmacyModels?> getbyid(int id) async {
    try {
      // Capturar os dados da farmácia pelo id
      final pharmacyData = await viewModel.repository.getPharmacyById(id);
      // Atualizar o viewModel com os dados capturados
      viewModel.updatePharmacyData(pharmacyData);
      // Retornar os dados da farmácia
      return pharmacyData;
    } catch (e) {
      // Tratar erros, se necessário
      if (kDebugMode) {
        print('Erro ao obter dados da farmácia: $e');
      }
    }
    // Adicionar um retorno padrão caso a execução chegue até aqui
    return null;
  }
}
