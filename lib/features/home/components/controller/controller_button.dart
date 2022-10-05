import 'package:flutter/material.dart';

class ControllerButton extends StatelessWidget {
  const ControllerButton({Key? key, required this.onPressed, required this.text, required this.icon}) : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          icon,
          Text(text),
        ],
      ),
    );
  }
}
