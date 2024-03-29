import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../../services/mqtt_client_service.dart';

class SliderWidget extends StatefulWidget {
  Function setlightValue;
  double lightValue;

  SliderWidget(
      {super.key, required this.setlightValue, required this.lightValue});

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network("https://cdn-icons-png.flaticon.com/128/1582/1582439.png",
            width: 59, height: 50),
        Slider(
          activeColor: Colors.yellow,
          thumbColor: Colors.white,
          inactiveColor: Colors.grey,
          value: widget.lightValue,
          min: 0,
          max: 100,
          divisions: 100,
          onChanged: (double value) {
            widget.setlightValue(value);
          },
        ),
      ],
    );
  }
}
