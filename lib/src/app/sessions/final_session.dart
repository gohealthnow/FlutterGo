import 'package:flutter/material.dart';
import 'package:gohealth/src/app/splash_page.dart';

class FinalSessionPage extends StatefulWidget {
  const FinalSessionPage({super.key});

  @override
  State<FinalSessionPage> createState() => FinalSessionState();
}

class FinalSessionState extends State<FinalSessionPage> {
  final _formKey = GlobalKey<FormState>();
  final List<bool> _checklistValues = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              const Text('Sua primeira consulta'),
              Image.asset('assets/images/Final_Session.png'),
              CheckboxListTile(
                  value: _checklistValues[0],
                  onChanged: (bool? value) {
                    setState(() {
                      _checklistValues[0] = value!;
                    });
                  },
                  title: const Text('Primeiro item')),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(
                          0, 90, 226, 0.85), // Cor do texto
                    ),
                    child: const Text('Anterior'),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight),
                      )
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SplashPage()));
                      }
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(
                          0, 90, 226, 0.85), // Cor do texto
                    ),
                    child: const Text('Próximo'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
