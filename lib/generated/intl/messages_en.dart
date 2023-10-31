// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(name) => "Server ${name} is not available";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appName": MessageLookupByLibrary.simpleMessage("FLUP Karaoke"),
        "artBy": MessageLookupByLibrary.simpleMessage("Art by "),
        "artist": MessageLookupByLibrary.simpleMessage("Artist"),
        "artistHint":
            MessageLookupByLibrary.simpleMessage("e.g.: Taylor Swift"),
        "awaitingQueryDescription": MessageLookupByLibrary.simpleMessage(
            "Enter a song name and/or an artist to search for songs."),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "insertANameForThisServer": MessageLookupByLibrary.simpleMessage(
            "Insert a name for this server"),
        "insertNewServer":
            MessageLookupByLibrary.simpleMessage("Insert new server"),
        "manualConnection":
            MessageLookupByLibrary.simpleMessage("Manual connection"),
        "manualConnectionButton":
            MessageLookupByLibrary.simpleMessage("Connect"),
        "manualConnectionDescription": MessageLookupByLibrary.simpleMessage(
            "Enter the address of the you want to connect to."),
        "manualConnectionPlaceholder":
            MessageLookupByLibrary.simpleMessage("Address"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "noItemsFound": MessageLookupByLibrary.simpleMessage("No items found"),
        "noMoreItems": MessageLookupByLibrary.simpleMessage(
            "There are no more items to show."),
        "nowPlaying": MessageLookupByLibrary.simpleMessage("Now Playing"),
        "playlists": MessageLookupByLibrary.simpleMessage("Playlists"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "serverIsNotAvailable": m0,
        "songHint": MessageLookupByLibrary.simpleMessage("e.g.: Blank Space"),
        "songTitle": MessageLookupByLibrary.simpleMessage("Song title")
      };
}
