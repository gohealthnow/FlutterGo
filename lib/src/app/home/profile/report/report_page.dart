import 'package:flutter/material.dart';
import 'package:gohealth/api/models/pharmacy_model.dart';
import 'package:gohealth/api/repositories/pharmacy_repository.dart';
import 'package:gohealth/src/app/home/profile/report/generated_report_page.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

// Page de relatórios de vendas e estoque de acordo com a farmacia
class _ReportPageState extends State<ReportPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatórios'),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              const Text('Relatório de Vendas e Estoque',
                  style: TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          FutureBuilder(
            future: PharmacyRepository().getAll(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final pharmacies = snapshot.data as List<PharmacyModels>;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: pharmacies.length,
                  itemBuilder: (context, index) {
                    final pharmacy = pharmacies[index];
                    return ListTile(
                      title: Text(pharmacy.name!),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                GeneratedReportPage(pharmacy: pharmacy)));
                      },
                        );
                  },
                );
                  }
            },
              ),
            ],
      )),
    );
  }
}
