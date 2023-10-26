import 'package:flup_karaoke/features/search/controller/search_view_controller.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flutter/material.dart';

class SearchBarComponent extends StatefulWidget {
  const SearchBarComponent({super.key, required this.controller});

  final SearchViewController controller;

  @override
  State<SearchBarComponent> createState() => _SearchBarComponentState();
}

class _SearchBarComponentState extends State<SearchBarComponent> {
  SearchViewController get controller => widget.controller;

  final _artistFocusNode = FocusNode();
  final _songTitleFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextFormField(
            focusNode: _songTitleFocusNode,
            onTapOutside: (_) => _songTitleFocusNode.unfocus(),
            controller: controller.songTitleController,
            decoration: InputDecoration(
              label: Text(FlupS.of(context).songTitle),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
              constraints: const BoxConstraints(maxHeight: 48),
              hintText: FlupS.of(context).songHint,
              prefixIcon: const Icon(Icons.music_note),
              suffixIcon: ValueListenableBuilder(
                valueListenable: controller.songTitleController,
                child: IconButton(padding: EdgeInsets.zero, onPressed: controller.songTitleController.clear, icon: const Icon(Icons.cancel)),
                builder: (context, value, child) => value.text.isEmpty ? const SizedBox() : child ?? const SizedBox(),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextFormField(
            focusNode: _artistFocusNode,
            onTapOutside: (_) => _artistFocusNode.unfocus(),
            controller: controller.artistController,
            decoration: InputDecoration(
              label: Text(FlupS.of(context).artist),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
              constraints: const BoxConstraints(maxHeight: 48),
              prefixIcon: const Icon(Icons.person),
              hintText: FlupS.of(context).artistHint,
              suffixIcon: ValueListenableBuilder(
                valueListenable: controller.artistController,
                child: IconButton(padding: EdgeInsets.zero, onPressed: controller.artistController.clear, icon: const Icon(Icons.cancel)),
                builder: (context, value, child) => value.text.isEmpty ? const SizedBox() : child ?? const SizedBox(),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
