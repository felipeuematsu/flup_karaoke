import 'package:flup_karaoke/features/app_strings.dart';

enum ScrollItemType {
  playlist,
  artist,
  ;

  String get title {
    switch (this) {
      case ScrollItemType.playlist:
        return AppStrings.playlistsTitle.tr;
      case ScrollItemType.artist:
        return AppStrings.artistsTitle.tr;
    }
  }
}
