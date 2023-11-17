import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileMenuTile extends StatelessWidget {
  const ProfileMenuTile({super.key, required this.icon, required this.title, required this.onTap});

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
      trailing: Theme.of(context).platform == TargetPlatform.iOS ? const Icon(CupertinoIcons.chevron_right) : const Icon(Icons.chevron_right),
    );
  }
}
