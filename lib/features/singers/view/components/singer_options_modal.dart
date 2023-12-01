import 'package:flup_karaoke/features/singers/view/components/edit_singer_modal.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SingerOptionsModal extends StatelessWidget {
  const SingerOptionsModal({super.key, required this.singer});

  final SingerModel singer;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) => ListView(shrinkWrap: true, children: [
        ListTile(
          leading: const Icon(Icons.person),
          title: Text(FlupS.of(context).edit),
          onTap: () async => showCupertinoModalBottomSheet(context: context, builder: (context) => EditSingerModal(singer: singer)),
        ),
        ListTile(
          leading: singer.active == true ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
          title: Text(singer.active == true ? FlupS.of(context).disable : FlupS.of(context).enable),
          onTap: () {},
        ),
      ]),
    );
  }
}
