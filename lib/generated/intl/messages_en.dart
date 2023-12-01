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

  static String m0(name) =>
      "Are you sure you want to remove \"${name}\" from the queue?";

  static String m1(name) => "Server \"${name}\" is not available";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addSongFromYoutube":
            MessageLookupByLibrary.simpleMessage("Add song from YouTube"),
        "addToQueue": MessageLookupByLibrary.simpleMessage("Add to queue"),
        "appName": MessageLookupByLibrary.simpleMessage("FLUP Karaoke"),
        "artBy": MessageLookupByLibrary.simpleMessage("Art by "),
        "artist": MessageLookupByLibrary.simpleMessage("Artist"),
        "artistHint":
            MessageLookupByLibrary.simpleMessage("e.g.: Taylor Swift"),
        "artistName": MessageLookupByLibrary.simpleMessage("Artist name"),
        "awaitingQueryDescription": MessageLookupByLibrary.simpleMessage(
            "Enter a song name and/or an artist to search for songs."),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "chooseFromLibrary":
            MessageLookupByLibrary.simpleMessage("Choose from Library"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "disable": MessageLookupByLibrary.simpleMessage("Disable"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "editSinger": MessageLookupByLibrary.simpleMessage("Edit singer"),
        "enable": MessageLookupByLibrary.simpleMessage("Enable"),
        "english": MessageLookupByLibrary.simpleMessage("English"),
        "error": MessageLookupByLibrary.simpleMessage("Error"),
        "filter": MessageLookupByLibrary.simpleMessage("Filter"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "insertANameForThisServer": MessageLookupByLibrary.simpleMessage(
            "Insert a name for this server"),
        "insertNewServer":
            MessageLookupByLibrary.simpleMessage("Insert new server"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
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
        "noResultsFound":
            MessageLookupByLibrary.simpleMessage("No results found."),
        "noSingersFound":
            MessageLookupByLibrary.simpleMessage("No singers found"),
        "noSingersFoundMessage": MessageLookupByLibrary.simpleMessage(
            "No singers found for this filter"),
        "noSongPlaying":
            MessageLookupByLibrary.simpleMessage("No song playing"),
        "noSongsInQueueYet": MessageLookupByLibrary.simpleMessage(
            "No songs in queue yet. Add some!"),
        "nowPlaying": MessageLookupByLibrary.simpleMessage("Now Playing"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "playlists": MessageLookupByLibrary.simpleMessage("Playlists"),
        "portuguese": MessageLookupByLibrary.simpleMessage("Português"),
        "profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "profileMenu": MessageLookupByLibrary.simpleMessage("Profile Menu"),
        "queue": MessageLookupByLibrary.simpleMessage("Queue"),
        "remove": MessageLookupByLibrary.simpleMessage("Remove"),
        "removeFromQueue":
            MessageLookupByLibrary.simpleMessage("Remove from queue"),
        "removeFromQueueMessage": m0,
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "selectDefaultSinger": MessageLookupByLibrary.simpleMessage(
            "You must select a default singer to use this feature"),
        "serverIsNotAvailable": m1,
        "singers": MessageLookupByLibrary.simpleMessage("Singers"),
        "songHint": MessageLookupByLibrary.simpleMessage("e.g.: Blank Space"),
        "songTitle": MessageLookupByLibrary.simpleMessage("Song title"),
        "takePhoto": MessageLookupByLibrary.simpleMessage("Take Photo"),
        "youCanReorderTheQueue":
            MessageLookupByLibrary.simpleMessage("You can reorder the queue!"),
        "youCanReorderTheQueueMessage": MessageLookupByLibrary.simpleMessage(
            "Just drag and drop the songs to reorder them."),
        "youtubeSearch": MessageLookupByLibrary.simpleMessage("Youtube Search")
      };
}
