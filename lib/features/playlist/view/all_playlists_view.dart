import 'package:auto_route/auto_route.dart';
import 'package:flup_karaoke/features/playlist/view/components/playlist_list_tile.dart';
import 'package:flup_karaoke/features/search/view/components/responses/no_items_found_widget.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

@RoutePage()
class AllPlaylistsView extends StatefulWidget {
  const AllPlaylistsView({super.key});

  @override
  State<AllPlaylistsView> createState() => _AllPlaylistsViewState();
}

class _AllPlaylistsViewState extends State<AllPlaylistsView> {
  final service = GetIt.I<KaraokeApiService>();

  final playlists = ValueNotifier<List<SimplePlaylistModel>?>(null);

  @override
  void initState() {
    super.initState();
    fetchPlaylists();
  }

  Future<void> fetchPlaylists() async {
    playlists.value = await service.getPlaylists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(FlupS.of(context).playlists), actions: [
        IconButton(
          onPressed: () async => playlists.value = await service.getPlaylists(),
          icon: const Icon(Icons.refresh),
        ),
      ]),
      body: Column(children: [
        Expanded(
          child: ValueListenableBuilder<List<SimplePlaylistModel>?>(
            valueListenable: playlists,
            builder: (context, value, child) {
              if (value == null) return const Center(child: CircularProgressIndicator());

              if (value.isEmpty) return const Center(child: NoItemsFoundWidget());

              return ListView.separated(
                separatorBuilder: (context, index) => const Gap(8),
                itemCount: value.length,
                itemBuilder: (context, index) => PlaylistListTile(simplePlaylistModel: value[index]),
              );
            },
          ),
        ),
      ]),
    );
  }
}
