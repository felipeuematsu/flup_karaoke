import 'package:flutter/material.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:flup_karaoke/features/app_strings.dart';
import 'package:flup_karaoke/features/singers/singers_edit_dialog.dart';

class SingersView extends StatefulWidget {
  const SingersView({Key? key, required this.service}) : super(key: key);

  final KaraokeApiService service;

  @override
  State<SingersView> createState() => _SingersViewState();
}

class _SingersViewState extends State<SingersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.singersTitle.tr),
        actions: [
          IconButton(
            onPressed: () => showDialog(context: context, builder: (context) => SingersEditDialog(service: widget.service, singer: const SingerModel())).then((_) => setState(() {})),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: widget.service.getSingers(),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (data != null) {

            if (data.isEmpty) {
              return  Center(child: Text(AppStrings.noSingers.tr));
            }

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return ListTile(
                  title: Text(item.name ?? ''),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => showDialog(context: context, builder: (context) => SingersEditDialog(service: widget.service, singer: item)).then((_) => setState(() {})),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
