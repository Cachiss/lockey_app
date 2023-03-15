import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String textContent;
  final Function onPressed;
  final Color backgroundColor;
  final Color fontColor;

  const ButtonWidget(
      {super.key,
      required this.textContent,
      required this.onPressed,
      this.backgroundColor = Colors.black,
      this.fontColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: backgroundColor,
          side: const BorderSide(
            color: Colors.black,
            width: 1,
          )),
      child: Text(
        textContent,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontFamily: 'Roboto',
          color: fontColor,
        ),
      ),
    );
  }
}
