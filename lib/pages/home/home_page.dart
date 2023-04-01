import 'package:app/services/mqtt_client_service.dart';
import 'package:app/widgets/cards/thing_card.dart';
import 'package:app/widgets/cards/user_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app/auth/auth.dart';
import 'package:app/auth/auth_checker.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:provider/provider.dart';

import '../../layouts/room_page.dart';
import '../../providers/topic_values.dart';
import '../../widgets/drawer/drawer_widget.dart';
import '../../widgets/slider/slider_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Auth auth = Auth();
  bool isConnected = false;
  bool isLocked = false;
  double lightValue = 0;

  var handleLock;
  var setLigthValue;
  var disconnectMqtt;
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () async {
      final MqttService mqttService = MqttService();
      final clientMqtt = mqttService.client;

      if (clientMqtt.connectionStatus!.state == MqttConnectionState.connected) {
        setState(() {
          isConnected = true;
        });
      }

      await mqttService.connectMqtt();
      mqttService.subscribeToTopic("home/lock");
      mqttService.subscribeToTopic("home/main/led");

      clientMqtt.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
        final String message =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        print("message desde el home: $message");
        final pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        if (c[0].topic == 'home/lock') {
          if (pt == 'lock') {
            print("es lock");
            setState(() {
              isLocked = true;
            });
          } else {
            print("es unlock");
            setState(() {
              isLocked = false;
            });
          }
        } else if (c[0].topic == 'home/main/led') {
          setState(() {
            lightValue = double.parse(pt);
          });
        }
      });
      setState(() {
        isConnected = true;
        handleLock = (bool value) {
          if (isLocked) {
            mqttService.publish("home/lock", "unlock");
          } else {
            mqttService.publish("home/lock", "lock");
          }
        };
        setLigthValue = (double value) {
          mqttService.publish("home/main/led", value.toString());
        };
        disconnectMqtt = () {
          clientMqtt.disconnect();
        };
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    //provider of lock state
    if (!isConnected) {
      return LockeyLayout(
          child: Container(
        //height of all screen, except appbar
        height: MediaQuery.of(context).size.height -
            AppBar().preferredSize.height -
            MediaQuery.of(context).padding.top,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ));
    }
    return AuthChecker(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: const Text("Lockey",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: 'Playfair',
                  fontWeight: FontWeight.w500)),
        ),
        drawer: DrawerWidget(disconnectMqtt: disconnectMqtt),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    "Hola, ${user?.displayName}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Playfair'),
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 50),
                      child: ThingCard(
                        switchState: isLocked,
                        handleLock: handleLock,
                      )),
                  /*Container(
                      margin: const EdgeInsets.only(top: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Luz en la sala Principal",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Playfair'),
                      )),*/
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Luz en la sala Principal",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Playfair')),
                  SliderWidget(
                      setlightValue: setLigthValue, lightValue: lightValue),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
