import 'package:flutter/material.dart';
import 'package:gohealth/src/app/sessions/final_session.dart';

class FirstSessionPage extends StatefulWidget {
  const FirstSessionPage({super.key});

  @override
  State<FirstSessionPage> createState() => FirstSessionState();
}

class FirstSessionState extends State<FirstSessionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Row(
        children: [
          Row(
            children: [
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(50)),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(50)),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(50)),
              )
            ],
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FinalSessionPage()));
            },
            style: TextButton.styleFrom(
              foregroundColor:
                  const Color.fromRGBO(0, 90, 226, 0.85), // Cor do texto
            ),
            child: const Text('Próximo'),
          ),
        ],
      ),
      body: Form(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset('assets/images/First_Session.png'),
              const Text('GoHealth',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const Text(
                  'Um aplicativo de consulta de medicamentos e orientação de rotas para conseguir em postos públicos',
                  style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
