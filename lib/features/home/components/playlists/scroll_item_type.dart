import 'package:flup_karaoke/features/app_strings.dart';
import 'package:flutter/widgets.dart';

enum ScrollItemType {
  playlist,
  artist,
  ;

  String title(BuildContext context) {
    switch (this) {
      case ScrollItemType.playlist:
        return AppStrings.playlistsTitle.tr(context);
      case ScrollItemType.artist:
        return AppStrings.artistsTitle.tr(context);
    }
  }
}
