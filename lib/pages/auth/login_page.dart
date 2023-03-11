import 'package:app/widgets/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:app/auth/auth.dart';
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
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Image(
                    image: AssetImage("assets/illustrations/ilustration_4.png"),
                    height: 250,
                    width: 240,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: const Text(
                            "Iniciar sesión",
                            style: TextStyle(
                                fontSize: 40,
                                fontFamily: 'Playfair',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[100],
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller:
                                      TextEditingController(text: email),
                                  decoration: const InputDecoration(
                                    hintText: "Correo electrónico",
                                    labelText: "Correo electrónico",
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1),
                                    ),
                                    prefixIcon: Icon(Icons.email),
                                  ),
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
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[100],
                                ),
                                child: TextFormField(
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    onSaved: (String? value) =>
                                        password = value!,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.lock),
                                        hintText: "Contraseña",
                                        labelText: "Contraseña",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 1),
                                        )),
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
                                margin: const EdgeInsets.only(top: 40),
                                width: 250,
                                height: 50,
                                child: ButtonWidget(
                                  textContent: "Iniciar sesión",
                                  onPressed: _submit,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "¿No tienes una cuenta?",
                              style: TextStyle(
                                  fontSize: 20, fontFamily: 'Playfair'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/register');
                              },
                              child: const Text("Regístrate",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Playfair',
                                      decoration: TextDecoration.underline)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
