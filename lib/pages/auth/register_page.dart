import 'package:app/widgets/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:app/auth/auth.dart';
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
      bool? response = await auth.signUpWithEmailAndPassword(
          name, email, password, setError);
      if (response == true) {
        //enviar a la página de login
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context, '/login');
        });
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
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Image(
                  image: AssetImage("assets/illustrations/illustration9.png"),
                  height: 250,
                  width: 240,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 25),
                  child: const Text("Regístrate en Lockey",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Playfair',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      //space between the elements
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[100],
                          ),
                          child: TextFormField(
                            onSaved: (value) => name = value!,
                            decoration: const InputDecoration(
                              hintText: "Nombre",
                              labelText: "Escribe tu nombre",
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "El nombre no puede estar vacío";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Container(
                            color: Colors.grey[100],
                            child: TextFormField(
                              onSaved: (value) => email = value!,
                              decoration: const InputDecoration(
                                hintText: "Correo electrónico",
                                labelText: "Correo electrónico",
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                              ),
                              validator: (value) {
                                if (!EmailValidator.validate(value!)) {
                                  return "El correo electrónico no es válido";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          color: Colors.grey[100],
                          child: TextFormField(
                            onSaved: (value) => password = value!,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              hintText: "Contraseña",
                              labelText: "Contraseña",
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1),
                              ),
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
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          color: Colors.grey[100],
                          child: TextFormField(
                            onSaved: (value) => passwordConfirm = value!,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              hintText: "Confirmar contraseña",
                              labelText: "Confirmar contraseña",
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1),
                              ),
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
                            width: 250,
                            height: 50,
                            margin: EdgeInsets.only(top: 10),
                            child: ButtonWidget(
                              onPressed: _submit,
                              textContent: "Registrarse",
                            )),
                      ],
                    )),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Ya tienes una cuenta?",
                      style: TextStyle(
                        fontFamily: 'Playfair',
                        fontSize: 20,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text(
                        "Inicia sesión",
                        style: TextStyle(
                          fontFamily: 'Playfair',
                          fontSize: 20,
                        ),
                      ),
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
