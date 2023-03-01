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
  String? error;

  void _submit() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      bool? response =
          await auth.signUpWithEmailAndPassword(email, password, setError);
      if (response == true) {
        //enviar a la página de login
        Navigator.pushReplacementNamed(context, '/login');
      }
    } else {
      print("no se pudo registrar");
    }
  }

  void setError(message) {
    setState(() {
      error = message;
    });
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
                          decoration: const InputDecoration(
                            hintText: "Nombre",
                            labelText: "Escribe tu nombre",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "El nombre no puede estar vacío";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          onSaved: (value) => email = value!,
                          decoration: const InputDecoration(
                            hintText: "Correo electrónico",
                            labelText: "Correo electrónico",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (!EmailValidator.validate(value!)) {
                              return "El correo electrónico no es válido";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          onSaved: (value) => password = value!,
                          decoration: const InputDecoration(
                            hintText: "Contraseña",
                            labelText: "Contraseña",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value != passwordConfirm) {
                              return "Las contraseñas no coinciden";
                            }
                            if (value!.length < 6 || value.isEmpty) {
                              return "La contraseña debe tener al menos 6 caracteres";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          onSaved: (value) => passwordConfirm = value!,
                          decoration: const InputDecoration(
                            hintText: "Confirmar contraseña",
                            labelText: "Confirmar contraseña",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value != password) {
                              return "Las contraseñas no coinciden";
                            }
                            if (value!.length < 6 || value.isEmpty) {
                              return "La contraseña debe tener al menos 6 caracteres";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (error != null)
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(bottom: 20),
                            child: Text(
                              error!,
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            child: ButtonWidget(
                              onPressed: _submit,
                              textContent: "Registrarse",
                            )),
                      ],
                    )),
                Row(
                  children: [
                    const Text("¿No tienes una cuenta?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: const Text("Inicia sesión"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
