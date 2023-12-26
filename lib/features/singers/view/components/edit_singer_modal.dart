import 'package:flup_karaoke/features/commons/widgets/adaptative_text_button.dart';
import 'package:flup_karaoke/features/commons/widgets/update_photo_modal.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class EditSingerModal extends StatefulWidget {
  const EditSingerModal({super.key, required this.singer});

  final SingerModel singer;

  @override
  State<EditSingerModal> createState() => _EditSingerModalState();
}

class _EditSingerModalState extends State<EditSingerModal> {
  final service = GetIt.I<KaraokeApiService>();
  late final nameController = TextEditingController(text: widget.singer.name);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(

      onClosing: () {},
      builder: (context) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(FlupS.of(context).editSinger),
          trailing: AdaptiveTextButton(
            onPressed: () => service.editSinger(widget.singer, null),
            child: Text(FlupS.of(context).save),
          ),
        ),
        child: SafeArea(
          child: Column(children: [
            const Gap(32),
            GestureDetector(
              onTap: () => showCupertinoModalBottomSheet(context: context, builder: (context) => UpdatePhotoModal(singer: widget.singer)),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: Image.network(
                    service.singerImageUrl(widget.singer.id ?? 0),
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(color: Colors.black26, child: const Icon(Icons.person, size: 128)),
                  ),
                ),
              ),
            ),
            const Gap(32),
            CupertinoTextField(controller: nameController, placeholder: FlupS.of(context).name),
          ]),
        ),
      ),
    );
  }
}
