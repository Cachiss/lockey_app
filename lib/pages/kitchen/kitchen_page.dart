import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../../layouts/room_page.dart';
import '../../services/mqtt_client_service.dart';
import '../../widgets/slider/slider_widget.dart';

class KitchenPage extends StatefulWidget {
  const KitchenPage({super.key});

  @override
  State<KitchenPage> createState() => _KitchenPageState();
}

class _KitchenPageState extends State<KitchenPage> {
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
      mqttService.subscribeToTopic("home/kitchen/led");

      clientMqtt.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
        final String message =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        print("message desde el home: $message");
        final pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        if (c[0].topic == 'home/kitchen/led') {
          setState(() {
            lightValue = double.parse(pt);
          });
        }
      });
      setState(() {
        isConnected = true;
        changeLightValue = (double value) {
          mqttService.publish("home/kitchen/led", value.toString());
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
            "https://cdn-icons-png.flaticon.com/512/7627/7627796.png",
            height: 200,
            width: 200,
          ),
          Text("Luz en la cocina",
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
