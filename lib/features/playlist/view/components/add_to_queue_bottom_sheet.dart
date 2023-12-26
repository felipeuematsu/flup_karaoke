import 'package:flup_karaoke/features/commons/controller/current_singer_controller.dart';
import 'package:flup_karaoke/features/commons/widgets/adaptative_text_button.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flup_karaoke/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AddToQueueBottomSheet extends StatefulWidget {
  const AddToQueueBottomSheet({super.key, required this.song});

  final SongModel song;

  @override
  State<AddToQueueBottomSheet> createState() => _AddToQueueBottomSheetState();
}

class _AddToQueueBottomSheetState extends State<AddToQueueBottomSheet> {
  final service = GetIt.I<KaraokeApiService>();
  final currentSingerController = GetIt.I<CurrentSingerController>();

  final ValueNotifier<SingerModel?> singer = ValueNotifier(null);
  final ValueNotifier<List<SingerModel>?> allSingers = ValueNotifier(null);
  final ValueNotifier<bool> isLoading = ValueNotifier(true);

  final singerFilterController = TextEditingController();
  final singerFilterFocusNode = FocusNode();

  Future<List<SingerModel>?>? allSingersFuture() async {
    isLoading.value = true;
    allSingers.value = null;
    isLoading.value = false;
    return allSingers.value ??= await service.getSingers();
  }

  @override
  void initState() {
    super.initState();
    singer.value = currentSingerController.currentSinger;

    allSingersFuture();
  }

  @override
  Widget build(BuildContext context) {
    final isIos = Theme.of(context).platform == TargetPlatform.iOS;

    return isIos ? cupertinoStyleBody(context) : materialStyleBody(context);
  }

  Widget cupertinoStyleBody(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoThemeData(brightness: FlupKApp.of(context).darkMode.value ? Brightness.dark : Brightness.light),
      child: Builder(builder: (context) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: CupertinoButton(padding: EdgeInsets.zero, onPressed: () => Navigator.of(context).pop(), child: Text(FlupS.of(context).cancel)),
            middle: Text(FlupS.of(context).addToQueue),
            trailing: AdaptiveTextButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                if (singer.value == null || singer.value?.id == null) return;
                service.addToQueue(widget.song.songId ?? 0, singer.value?.name ?? '');
                Navigator.of(context).pop();
              },
              child: Text(FlupS.of(context).addToQueue),
            ),
          ),
          child: Container(
            color: CupertinoTheme.of(context).scaffoldBackgroundColor,
            child: ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context, isLoading, child) => ValueListenableBuilder(
                valueListenable: singerFilterController,
                builder: (context, filter, child) => ValueListenableBuilder(
                  valueListenable: allSingers,
                  builder: (context, value, child) {
                    if (isLoading) return const Center(child: CupertinoActivityIndicator());

                    if (value == null) return Center(child: Text(FlupS.of(context).error));

                    if (value.isEmpty) return Center(child: Text(FlupS.of(context).noSingersFound));

                    final active = value.where((e) => e.active == true).toList();

                    if (active.isEmpty) return Center(child: Text(FlupS.of(context).noActiveSingers));

                    final filtered = active.where((e) => e.name?.toLowerCase().contains(filter.text.toLowerCase()) ?? false).toList();

                    return SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 32),
                      controller: ModalScrollController.of(context),
                      child: CupertinoFormSection.insetGrouped(
                        margin: const EdgeInsets.only(bottom: 128, left: 20, right: 20),
                        header: Column(mainAxisSize: MainAxisSize.min, children: [
                          Text(
                            FlupS.of(context).singers,
                            style: CupertinoTheme.of(context).textTheme.pickerTextStyle,
                          ),
                          const Gap(8),
                          CupertinoTextFormFieldRow(
                            focusNode: singerFilterFocusNode,
                            prefix: const Icon(CupertinoIcons.search),
                            placeholder: FlupS.of(context).filter,
                            controller: singerFilterController,
                          ),
                          if (filtered.isEmpty) Center(child: Text(FlupS.of(context).noSingersFoundMessage)),
                        ]),
                        children: [
                          if (filtered.isEmpty)
                            const SizedBox()
                          else
                            for (final e in filtered)
                              ValueListenableBuilder(
                                valueListenable: singer,
                                child: Image.network(
                                  service.singerImageUrl(e.id ?? 0),
                                  fit: BoxFit.cover,
                                  height: 32,
                                  width: 32,
                                  errorBuilder: (_, __, ___) => const Icon(CupertinoIcons.person, size: 32),
                                ),
                                builder: (context, singer, child) {
                                  final isSelected = singer?.id == e.id;
                                  return CupertinoListTile(
                                    trailing: isSelected ? const Icon(CupertinoIcons.checkmark) : null,
                                    leading: child,
                                    title: Text(e.name ?? '--', style: isSelected ? const TextStyle(color: CupertinoColors.systemBlue) : null),
                                    onTap: () => this.singer.value = e,
                                  );
                                },
                              ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  // cupertino equivalent in material
  Widget materialStyleBody(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: FittedBox(child: Text(FlupS.of(context).addToQueue))),
      body: Column(children: [
        const Gap(8),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (context, isLoading, child) => ValueListenableBuilder(
                valueListenable: singerFilterController,
                builder: (context, filter, child) {
                  return ValueListenableBuilder(
                    valueListenable: allSingers,
                    builder: (context, value, child) {
                      if (isLoading) return const Center(child: CupertinoActivityIndicator());

                      if (value == null) return Center(child: Text(FlupS.of(context).error));

                      if (value.isEmpty) return Center(child: Text(FlupS.of(context).noSingersFound));

                      final active = value.where((e) => e.active == true).toList();

                      if (active.isEmpty) return Center(child: Text(FlupS.of(context).noActiveSingers));

                      final filtered = active.where((e) => e.name?.toLowerCase().contains(filter.text.toLowerCase()) ?? false).toList();

                      return SingleChildScrollView(
                        child: Column(children: [
                          Text(
                            FlupS.of(context).singers,
                            style: CupertinoTheme.of(context).textTheme.pickerTextStyle,
                          ),
                          const Gap(8),
                          CupertinoTextFormFieldRow(
                            focusNode: singerFilterFocusNode,
                            prefix: const Icon(CupertinoIcons.search),
                            placeholder: FlupS.of(context).filter,
                            controller: singerFilterController,
                          ),
                          if (filtered.isEmpty) Center(child: Text(FlupS.of(context).noSingersFoundMessage)),
                          ValueListenableBuilder(
                            valueListenable: singer,
                            builder: (context, singer, child) => ListView.builder(
                              shrinkWrap: true,
                              controller: ModalScrollController.of(context),
                              itemCount: filtered.length,
                              itemBuilder: (context, index) {
                                final isSelected = singer?.id == filtered[index].id;
                                return ListTile(
                                  selected: isSelected,
                                  selectedTileColor: Colors.grey.shade300,
                                  leading: Image.network(
                                    service.singerImageUrl(filtered[index].id ?? 0),
                                    height: 32,
                                    width: 32,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 32),
                                  ),
                                  title: Text(filtered[index].name ?? '--', style: isSelected ? const TextStyle(color: Colors.blue) : null),
                                  onTap: () => this.singer.value = filtered[index],
                                );
                              },
                            ),
                          ),
                        ]),
                      );
                    },
                  );
                }),
          ),
        ),
        const Gap(8),
        ElevatedButton(
          onPressed: () {
            if (singer.value == null || singer.value?.id == null) return;
            service.addToQueue(widget.song.songId ?? 0, singer.value?.name ?? '');
            Navigator.of(context).pop();
          },
          child: Text(FlupS.of(context).addToQueue),
        ),
        const Gap(32),
      ]),
    );
  }
}
