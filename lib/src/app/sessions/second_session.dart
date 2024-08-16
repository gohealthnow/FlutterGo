import 'package:flutter/material.dart';
import 'package:gohealth/src/app/sessions/final_session.dart';
import 'package:gohealth/src/app/sessions/first_session.dart';

class SecondSessionPage extends StatefulWidget {
  const SecondSessionPage({super.key});

  @override
  State<SecondSessionPage> createState() => SecondSessionState();
}

class SecondSessionState extends State<SecondSessionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FirstSessionPage()));
            },
            style: TextButton.styleFrom(
              foregroundColor:
                  const Color.fromRGBO(0, 90, 226, 0.85), // Cor do texto
            ),
            child: const Text('Anterior'),
          ),
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
                decoration:
                    BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
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
              Image.asset('assets/images/Second_Session.png'),
              const Text('Consulta de produto'),
              const Text(
                  'Procure agora mesmo por medicamentos para hipertensão, diabetes, asma, ou colesterol alto. Nós ajudamos a encontrar a farmácia mais próxima com disponibilidade do que você precisa!'),
            ],
          ),
        ),
      ),
    );
  }
}
