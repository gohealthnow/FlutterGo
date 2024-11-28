import 'package:flutter/material.dart';
import 'package:gohealth/api/models/expert_doctor_models.dart';
import 'package:gohealth/src/app/home/home_page.dart';
import 'package:gohealth/src/components/checklist/Diagnois.dart';

class ChecklistPage extends StatefulWidget {
  final SymptomsDataRequest symptoms;
  const ChecklistPage({ Key? key, required this.symptoms}) : super(key: key);

  @override
  _ChecklistPageState createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  List<bool?> _checked = [];

  @override
  void initState() {
    super.initState();
    if (widget.symptoms.sintomas == null)
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Homepage()
        ),
      );
    _checked = List<bool?>.filled(widget.symptoms.sintomas!.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checklist de Sintomas',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 2,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange[300]!),
            ),
            child: const Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.orange),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Atenção: As informações fornecidas são apenas sugestivas. Consulte sempre um profissional de saúde para diagnóstico preciso.',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.symptoms.sintomas!.length,
              itemBuilder: (context, index) {
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: CheckboxListTile(
                    title: Text(
                      widget.symptoms.sintomas![index],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                      ),
                    ),
                    value: _checked[index],
                    onChanged: (value) {
                      setState(() {
                        _checked[index] = value;
                      });
                    },
                    activeColor: Colors.blueAccent,
                    checkColor: Colors.white,
                    subtitle: Text(
                      'Marque se você apresenta este sintoma',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          List<String> array = [];

          for (int i = 0; i < _checked.length; i++) {
            if (_checked[i] == true) {
              array.add(widget.symptoms.sintomas![i]);
            }
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Diagnois(array: array),
            ),
          );
        },
        icon: const Icon(Icons.check_circle_outline),
        label: const Text('Confirmar'),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}