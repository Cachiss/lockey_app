import 'package:app/layouts/room_page.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../../services/mqtt_client_service.dart';
import 'package:app/services/firestore_service.dart';
import 'package:encrypt/encrypt.dart';

class RegisterFingerprint extends StatefulWidget {
  const RegisterFingerprint({super.key});

  @override
  State<RegisterFingerprint> createState() => _RegisterFingerprintState();
}

class _RegisterFingerprintState extends State<RegisterFingerprint> {
  final FirestoreService _firestoreService = FirestoreService();
  final _formKey = GlobalKey<FormState>();

  bool isConnected = false;
  bool fingerprintRegistered = false;
  bool _isLoading = true;
  TextEditingController _controllerName = TextEditingController();

  void _showAlertDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Registrando huella..."),
          content: Container(
              height: 50,
              alignment: Alignment.center,
              child: const CircularProgressIndicator()),
          actions: [
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //alertdialog huella registrada
  void _showAlertDialogFingerprintRegistered() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Huella registrada"),
          content: const Text("La huella se ha registrado correctamente"),
          actions: [
            TextButton(
              child: const Text("Aceptar"),
              onPressed: () {
                _controllerName.clear();

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () async {
      final MqttService mqttService = MqttService();
      var clientMqtt = mqttService.client;
      if (clientMqtt.connectionStatus!.state == MqttConnectionState.connected) {
        print("connected");
      } else {
        print("not connected");
      }
      await mqttService.connectMqtt();
      mqttService.subscribeToTopic("home/fingerprint/loaded");

      clientMqtt.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
        final String message =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        print("message desde el home: $message");
        final pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        if (c[0].topic == 'home/fingerprint/loaded') {
          if (pt == 'true') {
            //delay 2 seconds
            setState(() {
              _isLoading = false;
            });
            Navigator.pop(context);

            Future.delayed(Duration.zero, () async {
              await _firestoreService
                  .addFingerprint({"name": _controllerName.text});
            });
            //vaciar el textfield
            _showAlertDialogFingerprintRegistered();
          }
        }
      });
      setState(() {
        isConnected = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isConnected) {
      return LockeyLayout(
          child: Container(
        height: MediaQuery.of(context).size.height -
            AppBar().preferredSize.height -
            MediaQuery.of(context).padding.top,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ));
    }

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
            Form(
              key: _formKey,
              child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre',
                  ),
                  controller: _controllerName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "El nombre no puede estar vacio";
                    }
                    return null;
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _showAlertDialog();
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                onPrimary: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              child: const Text("Registrar Huella",
                  style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
