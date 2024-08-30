import 'package:gohealth/api/layout/pharmacy_view_model.dart';
import 'package:gohealth/api/models/pharmacy_model.dart';
import 'package:gohealth/api/repositories/pharmacy_repository.dart';

class PharmacyController {

  // Dados simulados; substitua por chamadas à API
  List<String> banners = ['Banner 1', 'Banner 2', 'Banner 3'];

  Future<List<PharmacyModels>> fetchNearbyPharmacies() async {
    PharmacyViewModel viewModel = PharmacyViewModel(PharmacyRepository());
    return await viewModel.loadPharmacies();
  }

  // ! ainda não está funcionando a forma de consumir as farmacias proxima do usuario e nem ao menos saber o Km de cada uma delas.
  List<Map<String, String>> bestOffers = [
    {
      'image': 'https://via.placeholder.com/150',
      'price': 'R\$50.00',
      'description': 'Descrição do produto 1',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'price': 'R\$45,00',
      'description': 'Descrição do produto 2',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'price': 'R\$60,00',
      'description': 'Descrição do produto 3',
    },
  ];

  // Função para consumir ofertas da API
  Future<void> fetchBestOffers() async {
    // Simule uma requisição aqui
    // Exemplo: var response = await http.get('sua-api-url.com/ofertas');
    // Atualize 'bestOffers' com os dados da resposta
  }
}
