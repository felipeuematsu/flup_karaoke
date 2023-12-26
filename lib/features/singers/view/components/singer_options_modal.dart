import 'package:flup_karaoke/features/singers/view/components/edit_singer_modal.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SingerOptionsModal extends StatefulWidget {
  const SingerOptionsModal({super.key, required this.singer});

  final SingerModel singer;

  @override
  State<SingerOptionsModal> createState() => _SingerOptionsModalState();
}

class _SingerOptionsModalState extends State<SingerOptionsModal> {
  final service = GetIt.I<KaraokeApiService>();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Scaffold(
        body: BottomSheet(
          onClosing: () {},
          builder: (context) => ListView(shrinkWrap: true, children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(FlupS.of(context).edit),
              onTap: () => showBottomSheet(
                context: context,
                builder: (context) => EditSingerModal(singer: widget.singer),
              ),
            ),
            ListTile(
              leading: widget.singer.active == true ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
              title: Text(widget.singer.active == true ? FlupS.of(context).disable : FlupS.of(context).enable),
              onTap: () async {
                final newSinger = widget.singer.copyWith(active: widget.singer.active != true);
                await service.editSinger(newSinger, null);
                Navigator.of(context).pop();
              },
            ),
          ]),
        ),
      ),
    );
  }
}
