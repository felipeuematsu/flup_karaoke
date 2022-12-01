import 'package:flutter/material.dart';

class SettingsDropdownComponent<T> extends StatelessWidget {
  const SettingsDropdownComponent({
    Key? key,
    required this.leading,
    required this.title,
    required this.options,
    required this.onChanged,
  }) : super(key: key);

  final Widget leading;
  final String title;
  final List<T> options;
  final void Function(T?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox.square(dimension: 40, child: leading),
        const SizedBox(width: 8.0),
        Text(title),
        const Spacer(),
        DropdownButton(
          onChanged: onChanged,
          items: options.map((e) => DropdownMenuItem(value: e, child: Text(e.toString()))).toList(),
        ),
      ],
    );
  }
}
