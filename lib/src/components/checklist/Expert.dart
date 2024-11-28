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
  bool _isTextEmpty = true;

  SymptomsDataRequest symptoms = SymptomsDataRequest();

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      _isTextEmpty = _textController.text.trim().isEmpty;
    });
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    super.dispose();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Consultor de Saúde Virtual',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.blueAccent,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Como posso ajudar você hoje?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Descreva seus sintomas com detalhes para uma análise mais precisa.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[900],
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _textController,
                maxLines: 3,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                decoration: InputDecoration(
                  labelText: 'Sintomas',
                  hintText:
                      'Ex: Estou sentindo dor de cabeça e febre há 2 dias...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blueAccent.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: (_isLoading || _isTextEmpty)
                      ? null
                      : () async {
                          setState(() {
                            _isLoading = true;
                          });
                          await _fetchSymptoms();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ChecklistPage(symptoms: symptoms)),
                          );
                        },
                  icon: _isLoading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Icon(Icons.health_and_safety),
                  label: Text(
                    _isLoading ? 'Analisando...' : 'Analisar Sintomas',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
