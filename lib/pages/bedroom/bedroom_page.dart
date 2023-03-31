import 'package:app/layouts/room_page.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../../services/mqtt_client_service.dart';
import '../../widgets/slider/slider_widget.dart';

class BedroomPage extends StatefulWidget {
  const BedroomPage({super.key});

  @override
  State<BedroomPage> createState() => _BedroomPageState();
}

class _BedroomPageState extends State<BedroomPage> {
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
      mqttService.subscribeToTopic("home/bedroom/led");

      clientMqtt.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
        final String message =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        print("message desde el home: $message");
        final pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        if (c[0].topic == 'home/bedroom/led') {
          setState(() {
            lightValue = double.parse(pt);
          });
        }
      });
      setState(() {
        isConnected = true;
        changeLightValue = (double value) {
          mqttService.publish("home/bedroom/led", value.toString());
        };
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isConnected) {
      return LockeyLayout(
          child: Center(
        child: CircularProgressIndicator(),
      ));
    }
    return LockeyLayout(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          //imagen network
          Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Steel_bed.svg/1280px-Steel_bed.svg.png",
            height: 200,
            width: 200,
          ),
          Text("Luz en la habitación",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          SliderWidget(lightValue: lightValue, setlightValue: changeLightValue)
        ]),
      ),
    );
  }
}
