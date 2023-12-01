import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class QueueController {
  final service = GetIt.I<KaraokeApiService>();

  final queue = ValueNotifier<List<SongQueueItem>?>(null);

  Future<void> getQueue() async {
    queue.value = await service.getQueue();
  }

  Future<void> reorderQueue(int i, int newIndex) {
    final oldList = queue.value?.toList();
    final reorderedList = oldList?.reorder(i, newIndex);
    queue.value = reorderedList;
    return service.reorderQueue(i, newIndex);
  }
}

extension ReorderableList<T> on List<T> {
  List<T> reorder(int i, int newIndex) {
    final reorderedList = List<T>.from(this);
    final item = reorderedList.removeAt(i);
    reorderedList.insert(newIndex, item);
    return reorderedList;
  }
}
