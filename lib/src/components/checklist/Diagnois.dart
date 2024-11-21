import 'package:flutter/material.dart';
import 'package:gohealth/api/models/expert_doctor_models.dart';
import 'package:gohealth/api/repositories/expert_doctor_repository.dart';

class Diagnois extends StatefulWidget {
  Diagnois({Key? key, required this.array}) : super(key: key);

  final List<String> array;

  @override
  _DiagnoisState createState() => _DiagnoisState();
}

class _DiagnoisState extends State<Diagnois> {
  final ExpertDoctor _expertDoctor = ExpertDoctor();
  DiagnosticDataRequest? _diagnosticDataRequest;

  @override
  void initState() {
    super.initState();
    _fetchSymptoms();
  }

  Future<void> _fetchSymptoms() async {
    try {
      final result = await _expertDoctor.getDiagnosis(widget.array);
      setState(() {
        _diagnosticDataRequest = result;
      });
    } catch (e) {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('Erro ao tentar gerar os sintomas. Tente novamente.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnóstico'),
      ),
      body: _diagnosticDataRequest == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Image.asset(
                    'assets/images/title_image.png',
                    height: 100,
                    width: 100,
                  ),
                ),
                Text(
                  'Titulo: ${_diagnosticDataRequest!.title}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  'Probabilidade: ${_diagnosticDataRequest!.score}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
                Text(
                  'Descrição: ${_diagnosticDataRequest!.description}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
          )
    );
  }
}
