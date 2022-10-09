import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/features/app_strings.dart';
import 'package:karaoke_request_client/features/playlist/components/song_tile.dart';
import 'package:karaoke_request_client/features/search/components/song_search_service.dart';
import 'package:karaoke_request_client/features/widgets/add_to_queue_dialog/add_to_queue_dialog.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key, required this.service}) : super(key: key);

  final KaraokeApiService service;

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late final SongSearchService _songSearchService = SongSearchService(widget.service);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _artistController = TextEditingController();

  late final titleTextField = TextField(
    controller: _titleController,
    decoration: InputDecoration(hintText: AppStrings.songTitleHint.tr),
    onChanged: (value) => _songSearchService.titleStreamController.sink.add(value),
    onSubmitted: (value) => _songSearchService.search(),
  );
  late final artistTextField = TextField(
    controller: _artistController,
    decoration: InputDecoration(hintText: AppStrings.artistNameHint.tr),
    onChanged: (value) => _songSearchService.artistStreamController.sink.add(value),
    onSubmitted: (value) => _songSearchService.search(),
  );

  @override
  Widget build(BuildContext context) {
    final searchComponent = Row(
      children: [
        const SizedBox(width: 16.0),
        Expanded(child: titleTextField),
        const SizedBox(width: 16.0),
        Expanded(child: artistTextField),
        IconButton(onPressed: () => _songSearchService.search(), icon: const Icon(Icons.search)),
        const SizedBox(width: 16.0),
      ],
    );
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: StreamBuilder<List<SongModel>?>(
          stream: _songSearchService.songStream,
          builder: (context, snapshot) {
            final List<SongModel>? data = snapshot.data;
            if (data != null) {
              if (data.isEmpty) {
                return Column(
                  children: [
                    searchComponent,
                    Text(AppStrings.noResults.tr),
                  ],
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: data.length + 2,
                itemBuilder: (context, index) {
                  if (index == 0) return searchComponent;
                  if (index == data.length + 1) {
                    return _songSearchService.page != null ? IconButton(onPressed: () => _songSearchService.searchMore(), icon: const Icon(Icons.add), iconSize: 48.0) : const SizedBox();
                  }
                  final songModel = data[index - 1];
                  return SongTile(song: songModel, onTap: () => showDialog(context: context, builder: (context) => AddToQueueDialog(service: widget.service, song: songModel)));
                },
              );
            } else {
              return Column(
                children: [
                  const Spacer(),
                  searchComponent,
                  const Spacer(flex: 3),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
