import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String textContent;
  final Function onPressed;

  const ButtonWidget(
      {super.key, required this.textContent, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black87),
        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 50)),
      ),
      child: Text(textContent),
    );
  }
}
