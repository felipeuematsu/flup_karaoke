// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
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
  String get localeName => 'pt';

  static String m0(name) =>
      "Tem certeza que deseja remover \"${name}\" da fila?";

  static String m1(name) => "Servidor \"${name}\" não disponível";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "active": MessageLookupByLibrary.simpleMessage("Ativo"),
        "addSongFromYoutube":
            MessageLookupByLibrary.simpleMessage("Adicionar música do Youtube"),
        "addToQueue": MessageLookupByLibrary.simpleMessage("Adicionar à fila"),
        "appName": MessageLookupByLibrary.simpleMessage("FLUP Karaoke"),
        "artBy": MessageLookupByLibrary.simpleMessage("Arte por "),
        "artist": MessageLookupByLibrary.simpleMessage("Artista"),
        "artistHint": MessageLookupByLibrary.simpleMessage("ex: Taylor Swift"),
        "artistName": MessageLookupByLibrary.simpleMessage("Nome do artista"),
        "awaitingQueryDescription": MessageLookupByLibrary.simpleMessage(
            "Insira um nome de música ou artista para fazer a busca."),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "chooseFromLibrary":
            MessageLookupByLibrary.simpleMessage("Escolher da biblioteca"),
        "delete": MessageLookupByLibrary.simpleMessage("Excluir"),
        "disable": MessageLookupByLibrary.simpleMessage("Desativar"),
        "edit": MessageLookupByLibrary.simpleMessage("Editar"),
        "editSinger": MessageLookupByLibrary.simpleMessage("Editar cantor"),
        "enable": MessageLookupByLibrary.simpleMessage("Ativar"),
        "english": MessageLookupByLibrary.simpleMessage("English"),
        "error": MessageLookupByLibrary.simpleMessage("Erro"),
        "filter": MessageLookupByLibrary.simpleMessage("Filtro"),
        "home": MessageLookupByLibrary.simpleMessage("Início"),
        "inactive": MessageLookupByLibrary.simpleMessage("Inativo"),
        "insertANameForThisServer": MessageLookupByLibrary.simpleMessage(
            "Insira um nome para este servidor"),
        "insertNewServer":
            MessageLookupByLibrary.simpleMessage("Inserir novo servidor"),
        "language": MessageLookupByLibrary.simpleMessage("Linguagem"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "manualConnection":
            MessageLookupByLibrary.simpleMessage("Conexão manual"),
        "manualConnectionButton":
            MessageLookupByLibrary.simpleMessage("Conectar"),
        "manualConnectionDescription": MessageLookupByLibrary.simpleMessage(
            "Digite o endereço IP do servidor"),
        "manualConnectionPlaceholder":
            MessageLookupByLibrary.simpleMessage("Endereço"),
        "name": MessageLookupByLibrary.simpleMessage("Nome"),
        "noActiveSingers":
            MessageLookupByLibrary.simpleMessage("Nenhum cantor ativo"),
        "noItemsFound":
            MessageLookupByLibrary.simpleMessage("Nenhum item encontrado"),
        "noMoreItems": MessageLookupByLibrary.simpleMessage(
            "Não há mais itens para serem exibidos."),
        "noResultsFound":
            MessageLookupByLibrary.simpleMessage("Nenhum resultado encontrado"),
        "noSingersFound":
            MessageLookupByLibrary.simpleMessage("Nenhum cantor encontrado"),
        "noSingersFoundMessage": MessageLookupByLibrary.simpleMessage(
            "Nenhum cantor encontrado com esse nome"),
        "noSongPlaying":
            MessageLookupByLibrary.simpleMessage("Nenhuma música tocando"),
        "noSongsInQueueYet": MessageLookupByLibrary.simpleMessage(
            "Nenhuma música na fila ainda. Adicione uma música para começar!"),
        "nowPlaying": MessageLookupByLibrary.simpleMessage("Tocando agora"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "playlists": MessageLookupByLibrary.simpleMessage("Playlists"),
        "portuguese": MessageLookupByLibrary.simpleMessage("Português"),
        "profile": MessageLookupByLibrary.simpleMessage("Perfil"),
        "profileMenu": MessageLookupByLibrary.simpleMessage("Menu de perfil"),
        "queue": MessageLookupByLibrary.simpleMessage("Fila"),
        "remove": MessageLookupByLibrary.simpleMessage("Remover"),
        "removeFromQueue":
            MessageLookupByLibrary.simpleMessage("Remover da fila"),
        "removeFromQueueMessage": m0,
        "save": MessageLookupByLibrary.simpleMessage("Salvar"),
        "search": MessageLookupByLibrary.simpleMessage("Buscar"),
        "selectDefaultSinger": MessageLookupByLibrary.simpleMessage(
            "Você deve selecionar um cantor padrão para usar este recurso."),
        "serverIsNotAvailable": m1,
        "singers": MessageLookupByLibrary.simpleMessage("Cantores"),
        "songHint": MessageLookupByLibrary.simpleMessage("ex: Blank Space"),
        "songTitle": MessageLookupByLibrary.simpleMessage("Nome da música"),
        "takePhoto": MessageLookupByLibrary.simpleMessage("Tirar foto"),
        "youCanReorderTheQueue":
            MessageLookupByLibrary.simpleMessage("Você pode reordenar a fila!"),
        "youCanReorderTheQueueMessage": MessageLookupByLibrary.simpleMessage(
            "Arraste e solte as músicas para reordenar a fila."),
        "youtubeSearch":
            MessageLookupByLibrary.simpleMessage("Busca no Youtube")
      };
}
