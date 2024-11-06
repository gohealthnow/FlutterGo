import 'package:flutter/material.dart';
import 'package:gohealth/api/repositories/expert_doctor_repository.dart';
import 'package:http/http.dart';

class Expert extends StatefulWidget {
  @override
  _ExpertState createState() => _ExpertState();
}

class _ExpertState extends State<Expert> {
  final TextEditingController _controller = TextEditingController();
  late final ExpertDoctor expertDoctor;

  Future<Response> texto = Future.value(Response('', 200));

  @override
  void initState() {
    super.initState();
    expertDoctor = ExpertDoctor();
  }
  
  void getSymptoms(String prompt) {
    if (!mounted) return; // Verifica se o widget ainda está montado
    setState(() {
      texto = expertDoctor.getSymptoms(prompt) as Future<Response>;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<Response>(
              future: texto,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Erro: ${snapshot.error}');
                } else {
                  if (!snapshot.hasData || snapshot.data!.body.isEmpty) {
                    return const Center(child: Text('Nenhum produto encontrado.'));
                  } else {
                    return Text(snapshot.data.toString());
                  }
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'Digite o sintoma'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      getSymptoms(_controller.text);
                    },
                    child: Text('Enviar'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}