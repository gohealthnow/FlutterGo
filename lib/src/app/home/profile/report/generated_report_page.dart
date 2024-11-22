import 'package:flutter/material.dart';
import 'package:gohealth/api/models/pharmacy_model.dart';

class GeneratedReportPage extends StatefulWidget {
  GeneratedReportPage({super.key, required this.pharmacy});

  final PharmacyModels pharmacy;

  @override
  _GeneratedReportPageState createState() => _GeneratedReportPageState();
}

class _GeneratedReportPageState extends State<GeneratedReportPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relatório'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Relatório de vendas da farmácia ${widget.pharmacy.name}'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}