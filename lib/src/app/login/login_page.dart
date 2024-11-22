import 'package:flutter/material.dart';
import 'package:gohealth/api/layout/user_view_model.dart';
import 'package:gohealth/api/models/user_models.dart';
import 'package:gohealth/src/app/login/login_controller.dart';
import 'package:gohealth/src/app/register/register_page.dart';
import 'package:gohealth/api/repositories/user_repository.dart';
import 'package:gohealth/src/app/splash_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _controller = LoginController(UserViewModel(UserRepository()));

  @override
  void initState() {
    super.initState();
    _controller.deleteToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
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
                    'E-mail',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'Por favor, digite seu e-mail';
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(_emailController.text)) {
                        return 'Por favor, escreva um e-mail correto';
                      }
                      return null;
                    },
                    obscureText: false,
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
                    'Senha',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return 'Por favor digite sua senha';
                      } else if (password.length < 5) {
                        return 'A senha deve ter pelo menos 6 caracteres';
                      }
                      return null;
                    },
                    obscureText: true,
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
                    child: const Text('Esqueceu sua senha?'),
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
                onPressed: () async {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    final user = await _controller
                        .login(_emailController.text, _passwordController.text)
                        .then((value) => value)
                        .catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(error.toString()),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                      return UserModels();
                    });

                    if (user.id != null) {

                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SplashPage(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Usuário ou senha inválidos'),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                      _passwordController.clear();
                    }
                  }
                },
                child: const Text(
                  'Logar',
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()),
                  );
                },
                child: const Text('Crie uma conta',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color.fromRGBO(0, 90, 226, 0.85),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
