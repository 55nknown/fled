import 'dart:io';

import 'package:fled/controllers/dialog_controller.dart';
import 'package:fled/controllers/editor_environment.dart';
import 'package:fled/ui/dialogs/folder_picker_dialog.dart';
import 'package:fled/ui/fs_entry_item.dart';
import 'package:flutter/widgets.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

class ExplorerPanelWidget extends StatelessWidget {
  const ExplorerPanelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final env = Provider.of<EditorEnvironment>(context);

    if (env.workingDirectory != null) {
      final entries = Directory(env.workingDirectory!).listSync();
      entries.sort((a, b) => path.basename(a.path).compareTo(path.basename(b.path)));
      entries.sort((a, b) => a.statSync().type == FileSystemEntityType.directory ? 0 : 1);

      final children = [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            path.basename(env.workingDirectory!),
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        ...entries.map((e) => FsEntryItem(
              e,
              onPressed: () {
                if (e.statSync().type == FileSystemEntityType.file) {}
              },
            )),
      ];

      return ListView.builder(
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AdwButton.pill(
            onPressed: () {
              DialogController.openDialog<String?>(
                context: context,
                child: const FolderPickerDialog(),
              ).then((value) {
                if (value != null) {
                  Provider.of<EditorEnvironment>(context, listen: false).setWorkingDirectory(value);
                }
              });
            },
            child: const Text("Open Folder"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AdwButton.pill(
            onPressed: () {},
            child: const Text("Clone Repo"),
          ),
        ),
      ],
    );
  }
}
