import 'package:app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:app/auth.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final Auth auth = Auth();

  String email = '', password = '';
  bool _errorMessage = false;

  void _errorState() {
    setState(() {
      _errorMessage = true;
    });
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      auth.signInWithEmailAndPassword(email, password, _errorState);
    }
  }

  @override
  Widget build(BuildContext context) {
    auth.authStateChanges.listen((user) {
      if (user == null) {
        print('No ha iniciado sesión');
      } else {
        print('Ha iniciado sesión');
        Navigator.pushNamed(context, '/');
      }
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text("Bienvenido a Lockey",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )),
                  const Image(
                    image: AssetImage("assets/lockey-logo.png"),
                    height: 300,
                    width: 300,
                  ),
                  Container(
                    child: Center(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    hintText: "Correo electrónico",
                                    labelText: "Correo electrónico",
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingrese su correo electrónico';
                                  }
                                  if (!EmailValidator.validate(value)) {
                                    return 'Ingrese un correo electrónico correcto';
                                  }
                                  return null;
                                },
                                onSaved: (String? value) => email = value!,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  onSaved: (String? value) => password = value!,
                                  decoration: const InputDecoration(
                                      hintText: "Contraseña",
                                      labelText: "Contraseña",
                                      border: OutlineInputBorder()),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor ingrese su contraseña';
                                    }
                                    return null;
                                  }),
                            ),
                            if (_errorMessage)
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(top: 20),
                                child: const Text(
                                    "Usuario o contraseña incorrecta",
                                    style: TextStyle(color: Colors.red)),
                              ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: ButtonWidget(
                                textContent: "Iniciar sesión",
                                onPressed: _submit,
                              ),
                            ),
                            Row(
                              children: [
                                const Text("¿No tienes una cuenta?"),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/register');
                                  },
                                  child: const Text("Regístrate"),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
