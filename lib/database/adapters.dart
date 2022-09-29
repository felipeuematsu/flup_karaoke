
import 'package:hive/hive.dart';

final List<TypeAdapter> _adapters = [

];

void registerAdapters() {
  for (final adapter in _adapters) {
    Hive.registerAdapter(adapter);
  }
}
