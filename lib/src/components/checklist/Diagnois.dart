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
                    width: 300,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/Final_Diagnosis.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.blue[50]!, Colors.white],
                      ),
                    ),
                    child: Card(
                      elevation: 8,
                      margin: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.blue[100]!,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.medical_services_outlined,
                                    color: Colors.blue[700],
                                    size: 28,
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      '${_diagnosticDataRequest!.title}',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[700],
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Diagnóstico Sugerido',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue[900],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      '${_diagnosticDataRequest!.description}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey[800],
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ),
                ),
              ],
          )
    );
  }
}
