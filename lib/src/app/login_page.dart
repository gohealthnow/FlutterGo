import 'package:flutter/material.dart';
import 'package:gohealth/src/database/repositories/user.repository.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Email",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite seu email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Digite seu email',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w300,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0.0,
                        horizontal: 10.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Senha",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite sua senha';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      hintText: 'Digite sua senha',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w300,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0.0,
                        horizontal: 10.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
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
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                      const Color.fromARGB(255, 0, 91, 226)), // Cor de fundo
                  foregroundColor: WidgetStateProperty.all<Color>(
                      Colors.white), // Cor do texto
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8.0), // Bordas arredondadas
                    ),
                  ),
                  elevation: WidgetStateProperty.all<double>(5.0), // Sombra
                  padding: WidgetStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(
                        horizontal: 130.0, vertical: 15.0), // Tamanho do botão
                  ),
                ),
                onPressed: () {
                  UserRepository.authenticate(
                    _formKey,
                    _emailController,
                    _passwordController,
                  );
                },
                child: const Text(
                  'Entrar',
                  style: TextStyle(
                    fontSize: 18.0, // Tamanho do texto
                    fontWeight: FontWeight.w900, // Deixa o texto em negrito
                  ),
                ),
              ),
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
