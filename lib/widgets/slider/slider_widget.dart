import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../../services/mqtt_client_service.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({super.key});

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  final client = MqttService().client;

  double _value = 0;

  @override
  Widget build(BuildContext context) {
    return Slider(
      activeColor: Colors.yellow,
      thumbColor: Colors.white,
      inactiveColor: Colors.grey,
      value: _value,
      min: 0,
      max: 100,
      divisions: 100,
      label: '$_value',
      onChanged: (double value) {
        setState(() {
          _value = value;
        });
      },
    );
  }
}
