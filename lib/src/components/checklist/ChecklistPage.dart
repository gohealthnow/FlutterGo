import 'package:flutter/material.dart';
import 'package:gohealth/api/models/expert_doctor_models.dart';
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
    _checked = List<bool?>.filled(widget.symptoms.sintomas!.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checklist de Sintomas'),
      ),
      body: ListView.builder(
        itemCount: widget.symptoms.sintomas!.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(widget.symptoms.sintomas![index]),
            value: _checked[index],
            onChanged: (value) {
              setState(() {
                _checked[index] = value;
              });
            },
        );
        },
      ),
    floatingActionButton: FloatingActionButton(
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
      child: const Icon(Icons.send),
    ),
    );
  }
}