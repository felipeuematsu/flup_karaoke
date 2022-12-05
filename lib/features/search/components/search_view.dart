import 'package:flup_karaoke/features/app_strings.dart';
import 'package:flup_karaoke/features/playlist/components/song_tile.dart';
import 'package:flup_karaoke/features/search/components/song_search_service.dart';
import 'package:flup_karaoke/features/widgets/add_to_queue_dialog/add_to_queue_dialog.dart';
import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key, required this.service}) : super(key: key);

  final KaraokeApiService service;

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  KaraokeApiService get service => widget.service;

  late final SongSearchService _songSearchService = SongSearchService(service, () => _formKey.currentState?.validate() == true);

  final _titleController = TextEditingController();
  final _artistController = TextEditingController();
  final _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _scrollListener() async {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
      setState(() => _isLoading = true);
      await _songSearchService.searchMore();
      setState(() => _isLoading = false);
    }
  }

  void executeSearch() {
    if (_formKey.currentState?.validate() == true) {
      _refreshIndicatorKey.currentState?.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _titleTextField = TextFormField(
      validator: _songSearchService.titleValidator,
      textInputAction: TextInputAction.search,
      controller: _titleController,
      decoration: InputDecoration(hintText: AppStrings.songTitleHint.tr),
      onChanged: (value) => _songSearchService.titleStreamController.sink.add(value),
      onFieldSubmitted: (_) => executeSearch(),
    );

    final _artistTextField = TextFormField(
      validator: _songSearchService.artistValidator,
      textInputAction: TextInputAction.search,
      controller: _artistController,
      decoration: InputDecoration(hintText: AppStrings.artistNameHint.tr),
      onChanged: (value) => _songSearchService.artistStreamController.sink.add(value),
      onFieldSubmitted: (_) => executeSearch(),
    );

    final searchComponent = Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      margin: const EdgeInsets.all(16.0),
      child: Row(children: [
        Expanded(child: Form(key: _formKey, child: Column(children: [_artistTextField, _titleTextField, const SizedBox(height: 8.0)]))),
        IconButton(iconSize: 32, onPressed: executeSearch, icon: Icon(Icons.search, color: Theme.of(context).primaryColor))
      ]),
    );
    return StreamBuilder(
      stream: _songSearchService.songStream,
      builder: (context, snapshot) {
        final data = snapshot.data;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _songSearchService.search,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: (data?.length ?? 0) + (_isLoading ? 2 : 1),
              itemBuilder: (context, index) {
                if (index == 0) return searchComponent;
                if (data == null) return Column(children: [const Spacer(), searchComponent, const Spacer(flex: 3)]);
                if (data.isEmpty) return Column(children: [const Spacer(), searchComponent, const Spacer(), Text(AppStrings.noResults.tr), const Spacer(flex: 3)]);
                if (index == data.length + 1) return const SizedBox(height: 60.0, child: Center(child: CircularProgressIndicator()));
                return SongTile(
                  song: data[index - 1],
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => AddToQueueDialog(service: service, song: data[index - 1]),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
