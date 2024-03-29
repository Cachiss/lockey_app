import 'package:flutter/material.dart';

class FingerprintPage extends StatefulWidget {
  const FingerprintPage({super.key});

  @override
  State<FingerprintPage> createState() => _FingerprintPageState();
}

class _FingerprintPageState extends State<FingerprintPage> {
  @override
  Widget build(BuildContext context) {
    //return a form with one single text field for the fingerprint
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar huella"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Fingerprint",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Playfair'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Escribe el nombre de la persona",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Playfair'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nombre',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
