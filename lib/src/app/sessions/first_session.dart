import 'package:flutter/material.dart';
import 'package:gohealth/src/app/sessions/second_session.dart';

class FirstSessionPage extends StatefulWidget {
  const FirstSessionPage({super.key});

  @override
  State<FirstSessionPage> createState() => FirstSessionState();
}

class FirstSessionState extends State<FirstSessionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const FlutterLogo(
                size: 500,
              ),
              const Text('GoHealth'),
              const Text(
                  'Um aplicativo de consulta de medicamentos e orientação de rotas para conseguir em postos públicos'),
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
                            color: Theme.of(context).primaryColorLight),
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
                            color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SecondSessionPage(),
                        ),
                      );
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
