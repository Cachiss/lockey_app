import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

import '../certs_manager/certs_manager.dart';

class MqttService {
  static const url = 'a1ugah3gemg9dt-ats.iot.us-west-2.amazonaws.com';
  static const port = 8883;
  static var clientId = Uuid(options: {'grng': UuidUtil.cryptoRNG}).v4();
  // Create the client
  final client = MqttServerClient.withPort(url, clientId, port);
  //TopicValueProvider topicValueProvider = TopicValueProvider();
  //Provider.of<UserDataProvider>(context, listen: false).setData

  Future<void> connectMqtt() async {
    // Set secure
    client.secure = true;
    // Set Keep-Alive
    client.keepAlivePeriod = 20;
    // Set the protocol to V3.1.1 for AWS IoT Core, if you fail to do this you will not receive a connect ack with the response code
    client.setProtocolV311();
    // logging if you wish
    client.logging(on: false);
    // Set the security context as you need, note this is the standard Dart SecurityContext class.
    // If this is incorrect the TLS handshake will abort and a Handshake exception will be raised,
    // no connect ack message will be received and the broker will disconnect.
    // For AWS IoT Core, we need to set the AWS Root CA, device cert & device private key
    // Note that for Flutter users the parameters above can be set in byte format rather than file paths
    SecurityContext context = SecurityContext.defaultContext;
    ByteData rootCa = await rootBundle.load('assets/certs/AmazonRootCA1.pem');

    context.setClientAuthoritiesBytes(rootCa.buffer.asUint8List());
    context.useCertificateChainBytes(CertificateManager.clientCert);
    context.usePrivateKeyBytes(CertificateManager.privateKey);

    client.securityContext = context;
    // Setup the connection Message
    final connMess =
        MqttConnectMessage().withClientIdentifier(clientId).startClean();
    client.connectionMessage = connMess;

    // Connect the client
    try {
      print('MQTT client connecting to AWS IoT using certificates....');
      await client.connect();
    } on Exception catch (e) {
      print('MQTT client exception - $e');
      client.disconnect();
      exit(-1);
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT client connected to AWS IoT');

      // Publish to a topic of your choice after a slight delay, AWS seems to need this
      await MqttUtilities.asyncSleep(1);

      // Important: AWS IoT Core can only handle QOS of 0 or 1. QOS 2 (exactlyOnce) will fail!

      /* client.subscribe('home/lock', MqttQos.atLeastOnce);
      client.subscribe('home/room/led', MqttQos.atLeastOnce);
      // Print incoming messages from another client on this topic
      client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) async {
        final recMess = c[0].payload as MqttPublishMessage;
        final pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        print(c);
        print('Topic is <${c[0].topic}>, payload is <-- $pt -->');
        print('');
        if (c[0].topic == 'home/lock') {
          if (pt == 'lock') {
            print("es lock");
            topicValueProvider.lock = true;
          } else {
            print("es unlock");
            topicValueProvider.lock = false;
          }
        }
      }); */
    } else {
      print(
          'ERROR MQTT client connection failed - disconnecting, state is ${client.connectionStatus!.state}');
      client.disconnect();
    }
    //sleeping
  }

  void publish(String topic, String message) async {
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      final builder = MqttClientPayloadBuilder();
      builder.addString(message);
      client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!,
          retain: true);
    } else {
      print('ERROR: MQTT client not connected in publish');
    }
  }

  void disconnect() {
    client.disconnect();
  }

  void subscribeToTopic(String topic) {
    client.subscribe(topic, MqttQos.atLeastOnce);
  }
}
