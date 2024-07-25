import 'package:flutter/material.dart';
import 'package:gohealth/src/components/button_field.dart';
import 'package:gohealth/src/components/custom_input_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 50),
              const FlutterLogo(size: 100),
              const SizedBox(height: 50),
              const CustomInputField(
                labelText: 'Email',
                hintText: 'jonh_doe@gohealth.com',
              ),
              const SizedBox(height: 20),
              const CustomInputField(
                labelText: 'Senha',
                hintText: 'pao_sem_ceu',
                obscureText: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // Implementar ação de recuperação de senha
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(
                          0, 90, 226, 0.85), // Cor do texto
                    ),
                    child: const Text('Esqueceu a senha?'),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const ButtonField(textButton: "Entrar"),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 50),
              TextButton(
                onPressed: () {
                  // Implementar ação de cadastro
                },
                child: const Text('Você não se cadastrou? Clique aqui'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
