import 'package:app/widgets/drawer/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../../layouts/room_page.dart';
import '../../services/mqtt_client_service.dart';
import '../../widgets/slider/slider_widget.dart';

class LivingRoomPage extends StatefulWidget {
  const LivingRoomPage({super.key});

  @override
  State<LivingRoomPage> createState() => _LivingRoomPageState();
}

class _LivingRoomPageState extends State<LivingRoomPage> {
  bool isConnected = false;
  double lightValue = 0;
  var changeLightValue;

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
      mqttService.subscribeToTopic("home/livingroom/led");

      clientMqtt.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
        final String message =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        print("message desde el home: $message");
        final pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        if (c[0].topic == 'home/livingroom/led') {
          setState(() {
            lightValue = double.parse(pt);
          });
        }
      });
      setState(() {
        isConnected = true;
        changeLightValue = (double value) {
          mqttService.publish("home/livingroom/led", value.toString());
        };
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
    return LockeyLayout(
        child: Padding(
      padding: EdgeInsets.all(20),
      child: Column(children: [
        //imagen network
        Image.network(
          "https://cdn-icons-png.flaticon.com/512/1941/1941999.png",
          height: 200,
          width: 200,
        ),
        const Text("Luz en la sala principal",
            style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        SliderWidget(lightValue: lightValue, setlightValue: changeLightValue)
      ]),
    ));
  }
}
