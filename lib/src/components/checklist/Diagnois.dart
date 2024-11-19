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
  late DiagnosticDataRequest _diagnosticDataRequest;

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
      _fetchSymptoms();
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnóstico'),
      ),
      body: _diagnosticDataRequest == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Diagnóstico: ${_diagnosticDataRequest.title}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Descrição: ${_diagnosticDataRequest.description}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Porcentagem: ${_diagnosticDataRequest.score} / 10',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),

    );
  }
}
