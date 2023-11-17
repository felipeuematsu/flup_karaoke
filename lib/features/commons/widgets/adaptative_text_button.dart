import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextButton extends StatelessWidget {
  const AdaptiveTextButton({super.key, this.onPressed, required this.child, this.padding});

  final Widget child;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoButton(padding: padding, onPressed: onPressed, child: child);
    }
    return TextButton(
      onPressed: onPressed,
      child: Padding(padding: padding ?? EdgeInsets.zero, child: child),
    );
  }
}
