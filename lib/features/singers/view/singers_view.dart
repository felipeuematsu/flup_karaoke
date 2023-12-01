import 'package:auto_route/annotations.dart';
import 'package:flup_karaoke/features/singers/view/components/no_singers_found_widget.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(FlupS.of(context).singers)),
      body: SafeArea(
        child: ValueListenableBuilder<List<SingerModel>?>(
          valueListenable: singers,
          builder: (context, singers, child) {
            if (singers == null) return const Center(child: CircularProgressIndicator.adaptive());

            if (singers.isEmpty) return const Center(child: NoSingersFoundWidget());

            return ListView.separated(
              separatorBuilder: (_, __) => const Divider(),
              itemCount: singers.length,
              itemBuilder: (context, index) => ListTile(
                leading: Image.network(
                  service.singerImageUrl(singers[index].id ?? 0),
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.person),
                ),
                title: Text(singers[index].name ?? ''),
                subtitle: Text(singers[index].id.toString()),
              ),
            );
          },
        ),
      ),
    );
  }
}
