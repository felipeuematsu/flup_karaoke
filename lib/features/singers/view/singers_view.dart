import 'package:auto_route/annotations.dart';
import 'package:flup_karaoke/features/singers/view/components/no_singers_found_widget.dart';
import 'package:flup_karaoke/features/singers/view/components/singer_options_modal.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

@RoutePage()
class SingersView extends StatefulWidget {
  const SingersView({super.key});

  @override
  State<SingersView> createState() => _SingersViewState();
}

class _SingersViewState extends State<SingersView> {
  final service = GetIt.I<KaraokeApiService>();

  final singers = ValueNotifier<List<SingerModel>?>(null);

  @override
  void initState() {
    super.initState();
    refresh();
  }

  Future<void> refresh([_]) async {
    singers.value = await service.getSingers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(FlupS.of(context).singers)),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: singers,
          builder: (context, singers, child) {
            if (singers == null) return const Center(child: CircularProgressIndicator.adaptive());

            if (singers.isEmpty) return const Center(child: NoSingersFoundWidget());

            return ListView.separated(
              separatorBuilder: (_, __) => const Divider(),
              itemCount: singers.length,
              itemBuilder: (context, index) => ListTile(
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
                    builder: (context) => SingerOptionsModal(singer: singers[index]),
                  ).then(refresh),
                ),
                leading: Image.network(
                  service.singerImageUrl(singers[index].id ?? 0),
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.person),
                ),
                title: Text(singers[index].name ?? ''),
                subtitle: Text(singers[index].active == true ? FlupS.of(context).active : FlupS.of(context).inactive),
              ),
            );
          },
        ),
      ),
    );
  }
}
