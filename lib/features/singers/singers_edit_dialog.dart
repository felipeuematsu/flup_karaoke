import 'package:flup_karaoke/features/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class SingersEditDialog extends StatefulWidget {
  const SingersEditDialog({Key? key, required this.service, required this.singer}) : super(key: key);

  final KaraokeApiService service;
  final SingerModel singer;

  @override
  State<SingersEditDialog> createState() => _SingersEditDialogState();
}

class _SingersEditDialogState extends State<SingersEditDialog> {
  late final nameController = TextEditingController(text: widget.singer.name);

  bool isMakingRequest = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppStrings.editSinger.tr),
      content: TextField(
        controller: nameController,
        decoration: InputDecoration(labelText: AppStrings.name.tr),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppStrings.cancel.tr),
        ),
        TextButton(
          onPressed: isMakingRequest
              ? null
              : () {
                  setState(() => isMakingRequest = true);
                  if (widget.singer.id == null) {
                    widget.service.addSinger(nameController.text).then((value) => Navigator.of(context).pop());
                  } else {
                    widget.service.editSinger(widget.singer.copyWith(name: nameController.text)).then((_) => Navigator.of(context).pop());
                  }
                },
          child: Text(AppStrings.save.tr),
        ),
      ],
    );
  }
}
