import 'package:flutter/material.dart';
import 'package:gohealth/api/models/expert_doctor_models.dart';

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
        // Implement your logic to send the suspicion and return the result
        // For example, you can navigate to another page or show a dialog with the result
      },
      child: const Icon(Icons.send),
    ),
    );
  }
}