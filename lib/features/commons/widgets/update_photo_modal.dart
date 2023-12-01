import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class UpdatePhotoModal extends StatefulWidget {
  const UpdatePhotoModal({super.key, required this.singer});

  final SingerModel singer;

  @override
  State<UpdatePhotoModal> createState() => _UpdatePhotoModalState();
}

class _UpdatePhotoModalState extends State<UpdatePhotoModal> {
  final service = GetIt.I<KaraokeApiService>();

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) => ListView(shrinkWrap: true, children: [
        // ListTile(
        //   leading: const Icon(Icons.photo_camera),
        //   title: Text(FlupS.of(context).takePhoto),
        //   onTap: () {},
        // ),
        ListTile(
          leading: const Icon(Icons.photo_library),
          title: Text(FlupS.of(context).chooseFromLibrary),
          onTap: () async {
            final image = await FilePicker.platform.pickFiles(type: FileType.image);
            final path = image?.files.single.path;
            if (path == null) return;

            final cropped = await ImageCropper.platform.cropImage(
              sourcePath: path,
              aspectRatioPresets: [CropAspectRatioPreset.square],
              maxHeight: 512,
              maxWidth: 512,
            );
            if (cropped == null) return;

            final imageFile = MultipartFile.fromBytes(await cropped.readAsBytes(), filename: 'image.${cropped.path.split('.').last}');

            service.editSinger(widget.singer, imageFile);
          },
        ),

        const Divider(),

        ListTile(
          leading: const Icon(Icons.cancel),
          title: Text(FlupS.of(context).cancel),
          onTap: Navigator.of(context).pop,
        ),
      ]),
    );
  }
}
