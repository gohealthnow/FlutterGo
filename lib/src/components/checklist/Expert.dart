import 'package:flutter/material.dart';
import 'package:gohealth/api/models/expert_doctor_models.dart';
import 'package:gohealth/api/repositories/expert_doctor_repository.dart';
import 'package:gohealth/src/components/checklist/ChecklistPage.dart';

class Expert extends StatefulWidget {
  @override
  _ExpertState createState() => _ExpertState();
}

class _ExpertState extends State<Expert> {
  final ExpertDoctor _expertDoctor = ExpertDoctor();
  final TextEditingController _textController = TextEditingController();
  bool _isLoading = false;

  SymptomsDataRequest symptoms = SymptomsDataRequest();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _fetchSymptoms() async {
    try {
      symptoms = await _expertDoctor.getSymptoms(_textController.text);
      setState(() {});
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
    return (_expertDoctor.isConnected() == true)
        ? Column(
          children: <Widget>[
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Digite o que você está sentindo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isLoading || _textController.text.isEmpty
                  ? null
                  : () async {
                      setState(() {
                        _isLoading = true;
                      });
                      await _fetchSymptoms();
                      setState(() {
                        _isLoading = false;
                      });
                      if (symptoms.sintomas!.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ChecklistPage(symptoms: symptoms)),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Erro: Nenhum sintoma encontrado. Tente novamente.'),
                          ),
                        );
                      }
                    },
              child: _isLoading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : const Text('Enviar'),
            ),
            ],
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Aplicação em manutenção'),
              ],
            ),
    );
  }
}
