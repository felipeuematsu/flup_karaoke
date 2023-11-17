import 'package:flup_karaoke/features/commons/widgets/adaptative_text_button.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flutter/material.dart';

class NoDefaultSingerDialog extends StatelessWidget {
  const NoDefaultSingerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(FlupS.of(context).error),
      content: Text(FlupS.of(context).selectDefaultSinger),
      actions: [AdaptiveTextButton(onPressed: () => Navigator.of(context).pop(), child: Text(FlupS.of(context).ok))],
    );
  }
}
