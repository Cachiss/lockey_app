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
  final bool switchState;
  final Function handleLock;
  ThingCard({super.key, required this.switchState, required this.handleLock});

  @override
  State<ThingCard> createState() => _ThingCardState();
}

class _ThingCardState extends State<ThingCard> {
  final client = MqttService().client;
  bool isLocked = false;

  @override
  Widget build(BuildContext context) {
    bool switchState = widget.switchState;
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 2),
            color: const Color.fromARGB(223, 188, 174, 174)),
        child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.lock,
                      color: Colors.black,
                      size: 30,
                    ),
                    Switch(
                      value: !switchState,
                      onChanged: (bool value) {
                        widget.handleLock(value);
                        setState(() {
                          switchState = value;
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      !switchState
                          ? const Text(
                              "Abierta",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            )
                          : const Text(
                              "Cerrada",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                      Text(
                        "Puerta principal",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ],
            )),

        alignment: Alignment.center,
        //width 50% of screen
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.2,
      ),
    );
  }
}
