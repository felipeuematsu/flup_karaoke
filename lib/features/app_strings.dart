import 'package:get/get.dart';

enum AppStrings {
  appName,
  singerName,
  searchHint,
  navButtonHome,
  navButtonSearch,
  navButtonProfile,
  navButtonSettings,
  playlistsTitle,
  nowPlayingTitle,
  nowPlayingEmpty, timesPlayed,
  genericErrorMessage,
  ;

  String get tr => toString().tr;

  String get key => toString();
}

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "pt_BR": {
          AppStrings.appName.key: "Felipe Karaoke",
          AppStrings.singerName.key: "Seu nome",
          AppStrings.searchHint.key: "Insira o nome de uma música ou artista...",
          AppStrings.navButtonHome.key: "Início",
          AppStrings.navButtonSearch.key: "Buscar",
          AppStrings.navButtonProfile.key: "Perfil",
          AppStrings.navButtonSettings.key: "Configurações",
          AppStrings.playlistsTitle.key: "Playlists",
          AppStrings.nowPlayingTitle.key: "Tocando agora",
          AppStrings.nowPlayingEmpty.key: "Nenhuma música tocando agora",
          AppStrings.timesPlayed.key: " vezes tocada",
          AppStrings.genericErrorMessage.key: "Ocorreu um erro ):",

        },
        "en_US": {
          AppStrings.appName.key: "Felipe Karaoke",
          AppStrings.singerName.key: "Your Name",
          AppStrings.searchHint.key: "Enter a song or artist...",
          AppStrings.navButtonHome.key: "Home",
          AppStrings.navButtonSearch.key: "Search",
          AppStrings.navButtonProfile.key: "Profile",
          AppStrings.navButtonSettings.key: "Settings",
          AppStrings.playlistsTitle.key: "Playlists",
          AppStrings.nowPlayingTitle.key: "Now Playing",
          AppStrings.nowPlayingEmpty.key: "No song playing now",
          AppStrings.timesPlayed.key: " times played",
          AppStrings.genericErrorMessage.key: "An error occurred ):",
        },
      };
}
