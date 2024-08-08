import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gohealth/api/layout/user_view_model.dart';
import 'package:gohealth/api/models/user_models.dart';
import 'package:gohealth/api/repositories/user_repository.dart';
import 'package:gohealth/src/app/home/home_page.dart';
import 'package:gohealth/src/app/login/login_page.dart';
import 'package:gohealth/src/app/register/register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final _controller = RegisterController(UserViewModel(UserRepository()));

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
                    "Full name",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    validator: (name) {
                      if (name == null || name.isEmpty) {
                        return 'Please enter your name complete';
                      }

                      final List<String> nameParts = name.split(' ');
                      final String firstName = nameParts[0];
                      final String lastName =
                          nameParts.length > 1 ? nameParts[1] : '';

                      if (firstName.length < 3 || lastName.length < 3) {
                        return 'Please enter your full name';
                      }

                      return null;
                    },
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: "Enter your full name",
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
                    "Email",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(email)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: "Enter your Email",
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
                    "Password",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 5) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: "Enter your Password",
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
                    child: const Text('Forget your Password?'),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    const Color.fromARGB(255, 0, 91, 226), // Cor de fundo
                  ),
                  foregroundColor: WidgetStateProperty.all<Color>(
                    Colors.white, // Cor do texto
                  ),
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
                    if (kDebugMode) {
                      print("Formulário validado com sucesso");
                    }
                    UserModels user = await _controller
                        .registerUser(_nameController.text,
                            _emailController.text, _passwordController.text)
                        .then((value) => value)
                        .catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: $error'),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                      return Future<UserModels>.value(UserModels());
                    });

                    if (user.id != null) {
                      await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Homepage(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Invalid email or password'),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  }
                },
                child: const Text(
                  'Register',
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
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text('Log in to your existing account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
