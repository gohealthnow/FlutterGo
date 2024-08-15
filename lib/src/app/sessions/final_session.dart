import 'package:flutter/material.dart';

class FinalSessionPage extends StatefulWidget {
  const FinalSessionPage({super.key});

  @override
  State<FinalSessionPage> createState() => FinalSessionState();
}

class FinalSessionState extends State<FinalSessionPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Row(
        children: [
          TextButton(
            onPressed: () {},
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
                    BoxDecoration(color: Theme.of(context).primaryColorLight),
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
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              const Text('Sua primeira consulta'),
              Image.asset('assets/images/Final_Session.png'),
              
            ],
          ),
        ),
      ),
    );
  }
}
