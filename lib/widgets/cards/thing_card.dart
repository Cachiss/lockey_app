import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app/services/mqtt_client_service.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../providers/topic_values.dart';

class ThingCard extends StatefulWidget {
  final Widget child;

  ThingCard({super.key, required this.child});

  @override
  State<ThingCard> createState() => _ThingCardState();
}

class _ThingCardState extends State<ThingCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TopicValueProvider>(
      builder: (context, topicValueProvider, child) {
        return Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  topicValueProvider.lock.toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Playfair'),
                ),
                ElevatedButton(
                    onPressed: () {
                      MqttService().publish("home/lock", "lock");
                    },
                    child: Text("Cambiar estado"))
              ],
            ));
      },
    );
  }
}
