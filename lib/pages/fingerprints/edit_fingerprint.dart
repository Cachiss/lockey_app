import 'package:app/layouts/room_page.dart';
import 'package:flutter/material.dart';

import '../../services/firestore_service.dart';

class EditFingerprint extends StatefulWidget {
  EditFingerprint({super.key});

  @override
  State<EditFingerprint> createState() => _EditFingerprintState();
}

class _EditFingerprintState extends State<EditFingerprint> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _idController = TextEditingController();

  final _firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    //recuperar el argumento que se le pasa a la pagina
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    _nameController.text = data['name'];
    _idController.text = data['id_fingerprint'].toString();
    return LockeyLayout(
        child: Container(
      padding: EdgeInsets.all(30),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              //textformfield con el valor del nombre de la huella
              /*
              TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre',
                  ),
                  controller: _controllerName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "El nombre no puede estar vacio";
                    }
               */
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: const OutlineInputBorder(),
                  labelText: 'ID Huella',
                ),
                enabled: false,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    /* Navigator.pop(context, {
                      'name': _nameController.text,
                      'id_fingerprint': int.parse(_idController.text)
                    }); */
                    Future.delayed(Duration.zero, () async {
                      await _firestoreService.updateFingerprint(
                          data['id_user'], _nameController.text);
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text('Guardar'),
              )
            ],
          )),
    ));
  }
}
