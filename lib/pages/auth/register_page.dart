import 'package:app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:app/auth.dart';
import 'package:email_validator/email_validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final Auth auth = Auth();
  final _formKey = GlobalKey<FormState>();

  String email = '', password = '', name = '', passwordConfirm = '';

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await auth.signUpWithEmailAndPassword(email, password);
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      print("no se pudo registrar");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                const Text("Regístrate",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )),
                /*  const Text("Bienvenido a Lockey",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )), */
                const Image(
                  image: AssetImage("assets/lockey-logo.png"),
                  height: 300,
                  width: 300,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      //space between the elements
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          onSaved: (value) => name = value!,
                          decoration: InputDecoration(
                            hintText: "Nombre",
                            labelText: "Escribe tu nombre",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextFormField(
                          onSaved: (value) => email = value!,
                          decoration: InputDecoration(
                            hintText: "Correo electrónico",
                            labelText: "Correo electrónico",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextFormField(
                          onSaved: (value) => password = value!,
                          decoration: InputDecoration(
                            hintText: "Contraseña",
                            labelText: "Contraseña",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextFormField(
                          onSaved: (value) => passwordConfirm = value!,
                          decoration: InputDecoration(
                            hintText: "Confirmar contraseña",
                            labelText: "Confirmar contraseña",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            child: ButtonWidget(
                              onPressed: _submit,
                              textContent: "Registrarse",
                            )),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
