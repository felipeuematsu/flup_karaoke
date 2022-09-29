import 'package:flutter/material.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({Key? key, required this.icon, required this.text, required this.onTap}) : super(key: key);

  final Widget icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(text, style: Theme.of(context).textTheme.titleMedium),
      dense: false,
      onTap: onTap,
    );
  }
}
