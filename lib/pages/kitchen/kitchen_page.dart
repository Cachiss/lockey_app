import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../../layouts/room_page.dart';
import '../../services/mqtt_client_service.dart';

class KitchenPage extends StatefulWidget {
  const KitchenPage({super.key});

  @override
  State<KitchenPage> createState() => _KitchenPageState();
}

class _KitchenPageState extends State<KitchenPage> {
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
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LockeyLayout(
        child: Center(
      child: Text("hola xd"),
    ));
  }
}
