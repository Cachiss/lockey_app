import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                              child: const TextField(
                                decoration: InputDecoration(
                                  hintText: "Nombre de usuario",
                                  labelText: "Nombre de usuario",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: const TextField(
                                decoration: InputDecoration(
                                    hintText: "Correo electrónico",
                                    labelText: "Correo electrónico",
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: const TextField(
                                decoration: InputDecoration(
                                    hintText: "Contraseña",
                                    labelText: "Contraseña",
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Confirmar"),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.black87),
                                    minimumSize: MaterialStateProperty.all(
                                        const Size(double.infinity, 50)),
                                  )),
                            ),
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
