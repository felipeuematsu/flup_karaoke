import 'package:flutter/material.dart';

class ControllerButton extends StatelessWidget {
  const ControllerButton({Key? key, required this.onPressed, required this.text, required this.icon}) : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 200),
      child: ElevatedButton(
        onPressed: onPressed,
        child: AspectRatio(
          aspectRatio: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              icon,
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
