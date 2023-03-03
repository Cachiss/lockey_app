import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String textContent;
  final Function onPressed;

  const ButtonWidget(
      {super.key,
      required this.textContent,
      required this.onPressed,
      String? fontSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.black),
      child: Text(
        textContent,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }
}
