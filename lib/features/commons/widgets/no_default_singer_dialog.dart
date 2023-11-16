import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flutter/material.dart';

class NoDefaultSingerDialog extends StatelessWidget {
  const NoDefaultSingerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(FlupS.of(context).error),
      content: Text(FlupS.of(context).selectDefaultSinger),
      actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(FlupS.of(context).ok))],
    );
  }
}
