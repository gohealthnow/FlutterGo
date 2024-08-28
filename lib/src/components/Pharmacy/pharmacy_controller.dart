import 'package:flutter/material.dart';

class PharmacyController {
  // Dados simulados; substitua por chamadas à API
  List<String> banners = ['Banner 1', 'Banner 2', 'Banner 3'];
  List<Color> nearbyPharmacies = [Colors.green, Colors.brown, Colors.grey, Colors.pink, Colors.red];
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
