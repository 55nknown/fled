import 'dart:io';

import 'package:fled/theme.dart';
import 'package:fled/ui/fs_entry_item.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:path/path.dart' as path;

class FsTreeView extends StatefulWidget {
  const FsTreeView({Key? key, this.cwd = "/", this.onChange}) : super(key: key);

  final String cwd;
  final void Function(String)? onChange;

  @override
  State<FsTreeView> createState() => _FsTreeViewState();
}

class _FsTreeViewState extends State<FsTreeView> {
  String cwd = "";

  @override
  void initState() {
    super.initState();
    cwd = widget.cwd;
  }

  final locationScrollController = ScrollController();

  void _setCwd(String val) {
    setState(() => cwd = path.normalize(val));
    if (widget.onChange != null) widget.onChange!(val);
  }

  @override
  Widget build(BuildContext context) {
    List<FileSystemEntity> entries = Directory(cwd).listSync();
    entries.sort((a, b) => a.path.compareTo(b.path));
    entries = entries.where((e) => !path.basename(e.path).startsWith('.')).toList();
    entries = entries.where((e) => e.statSync().type == FileSystemEntityType.directory).toList();

    List<String> paths = path.split(path.normalize(cwd));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 8.0),
                child: AdwButton.circular(
                  size: 32.0,
                  onPressed: () {
                    cwd += "/../";
                    _setCwd(cwd);
                    locationScrollController.animateTo(100000, duration: const Duration(microseconds: 200), curve: Curves.ease);
                  },
                  child: const Icon(FeatherIcons.chevronLeft),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SingleChildScrollView(
                    controller: locationScrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        paths.length * 2 - 1,
                        (index) => index % 2 == 0
                            ? AdwButton.flat(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
                                onPressed: () {
                                  _setCwd(path.joinAll(paths.sublist(0, index ~/ 2 + 1)));
                                },
                                child: Text(index == 0 ? "Computer" : paths[index ~/ 2]),
                              )
                            : Text("/", style: TextStyle(color: Theme.of(context).muted)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];

              return FsEntryItem(
                entry,
                onPressed: () {
                  _setCwd(entry.path);
                  locationScrollController.animateTo(100000, duration: const Duration(microseconds: 200), curve: Curves.ease);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
