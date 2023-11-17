// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class FlupS {
  FlupS();

  static FlupS? _current;

  static FlupS get current {
    assert(_current != null,
        'No instance of FlupS was loaded. Try to initialize the FlupS delegate before accessing FlupS.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<FlupS> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = FlupS();
      FlupS._current = instance;

      return instance;
    });
  }

  static FlupS of(BuildContext context) {
    final instance = FlupS.maybeOf(context);
    assert(instance != null,
        'No instance of FlupS present in the widget tree. Did you add FlupS.delegate in localizationsDelegates?');
    return instance!;
  }

  static FlupS? maybeOf(BuildContext context) {
    return Localizations.of<FlupS>(context, FlupS);
  }

  /// `FLUP Karaoke`
  String get appName {
    return Intl.message(
      'FLUP Karaoke',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Manual connection`
  String get manualConnection {
    return Intl.message(
      'Manual connection',
      name: 'manualConnection',
      desc: '',
      args: [],
    );
  }

  /// `Enter the address of the you want to connect to.`
  String get manualConnectionDescription {
    return Intl.message(
      'Enter the address of the you want to connect to.',
      name: 'manualConnectionDescription',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get manualConnectionPlaceholder {
    return Intl.message(
      'Address',
      name: 'manualConnectionPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Connect`
  String get manualConnectionButton {
    return Intl.message(
      'Connect',
      name: 'manualConnectionButton',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Art by `
  String get artBy {
    return Intl.message(
      'Art by ',
      name: 'artBy',
      desc: '',
      args: [],
    );
  }

  /// `Insert new server`
  String get insertNewServer {
    return Intl.message(
      'Insert new server',
      name: 'insertNewServer',
      desc: '',
      args: [],
    );
  }

  /// `Insert a name for this server`
  String get insertANameForThisServer {
    return Intl.message(
      'Insert a name for this server',
      name: 'insertANameForThisServer',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Artist`
  String get artist {
    return Intl.message(
      'Artist',
      name: 'artist',
      desc: '',
      args: [],
    );
  }

  /// `Song title`
  String get songTitle {
    return Intl.message(
      'Song title',
      name: 'songTitle',
      desc: '',
      args: [],
    );
  }

  /// `e.g.: Taylor Swift`
  String get artistHint {
    return Intl.message(
      'e.g.: Taylor Swift',
      name: 'artistHint',
      desc: '',
      args: [],
    );
  }

  /// `e.g.: Blank Space`
  String get songHint {
    return Intl.message(
      'e.g.: Blank Space',
      name: 'songHint',
      desc: '',
      args: [],
    );
  }

  /// `No items found`
  String get noItemsFound {
    return Intl.message(
      'No items found',
      name: 'noItemsFound',
      desc: '',
      args: [],
    );
  }

  /// `Enter a song name and/or an artist to search for songs.`
  String get awaitingQueryDescription {
    return Intl.message(
      'Enter a song name and/or an artist to search for songs.',
      name: 'awaitingQueryDescription',
      desc: '',
      args: [],
    );
  }

  /// `There are no more items to show.`
  String get noMoreItems {
    return Intl.message(
      'There are no more items to show.',
      name: 'noMoreItems',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Playlists`
  String get playlists {
    return Intl.message(
      'Playlists',
      name: 'playlists',
      desc: '',
      args: [],
    );
  }

  /// `Now Playing`
  String get nowPlaying {
    return Intl.message(
      'Now Playing',
      name: 'nowPlaying',
      desc: '',
      args: [],
    );
  }

  /// `Server "{name}" is not available`
  String serverIsNotAvailable(Object name) {
    return Intl.message(
      'Server "$name" is not available',
      name: 'serverIsNotAvailable',
      desc: '',
      args: [name],
    );
  }

  /// `No song playing`
  String get noSongPlaying {
    return Intl.message(
      'No song playing',
      name: 'noSongPlaying',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `You must select a default singer to use this feature`
  String get selectDefaultSinger {
    return Intl.message(
      'You must select a default singer to use this feature',
      name: 'selectDefaultSinger',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Add to queue`
  String get addToQueue {
    return Intl.message(
      'Add to queue',
      name: 'addToQueue',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `No singers found for this filter`
  String get noSingersFoundMessage {
    return Intl.message(
      'No singers found for this filter',
      name: 'noSingersFoundMessage',
      desc: '',
      args: [],
    );
  }

  /// `Singers`
  String get singers {
    return Intl.message(
      'Singers',
      name: 'singers',
      desc: '',
      args: [],
    );
  }

  /// `Youtube Search`
  String get youtubeSearch {
    return Intl.message(
      'Youtube Search',
      name: 'youtubeSearch',
      desc: '',
      args: [],
    );
  }

  /// `No results found.`
  String get noResultsFound {
    return Intl.message(
      'No results found.',
      name: 'noResultsFound',
      desc: '',
      args: [],
    );
  }

  /// `Add song from YouTube`
  String get addSongFromYoutube {
    return Intl.message(
      'Add song from YouTube',
      name: 'addSongFromYoutube',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Artist name`
  String get artistName {
    return Intl.message(
      'Artist name',
      name: 'artistName',
      desc: '',
      args: [],
    );
  }

  /// `Profile Menu`
  String get profileMenu {
    return Intl.message(
      'Profile Menu',
      name: 'profileMenu',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<FlupS> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pt'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<FlupS> load(Locale locale) => FlupS.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
