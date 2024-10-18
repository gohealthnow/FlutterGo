import 'package:flutter/material.dart';
import 'package:gohealth/api/repositories/pharmacy_repository.dart';
import 'package:gohealth/api/repositories/product_repository.dart';
import 'package:gohealth/src/app/home/profile/report/generated_report_page.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

// Page de relatórios de vendas e estoque de acordo com a farmacia
class _ReportPageState extends State<ReportPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameControllerPharmacyInput = TextEditingController();
  final _repository = ProductRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatórios'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text('Relatório de Vendas e Estoque',
                  style: TextStyle(fontSize: 20)),
              TextFormField(
                controller: _nameControllerPharmacyInput,
                decoration:
                    const InputDecoration(labelText: 'Nome da Farmácia'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome da farmácia é obrigatório';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    PharmacyRepository()
                        .getPharmacyByName(_nameControllerPharmacyInput.text)
                        .then((pharmacyList) {
                      if (pharmacyList.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GeneratedReportPage(
                                pharmacy: pharmacyList.first),
                          ),
                        );
                      } else {
                        // Handle the case where no pharmacy is found
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Nenhuma farmácia encontrada'),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      }
                    });
                  }
                },
                child: const Text('Gerar Relatório'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
