import 'package:adwaita_icons/adwaita_icons.dart';
import 'package:fled/theme.dart';
import 'package:fled/ui/fs_tree_view.dart';
import 'package:flutter/widgets.dart';
import 'package:libadwaita/libadwaita.dart';

class FolderPickerDialog extends StatefulWidget {
  const FolderPickerDialog({Key? key}) : super(key: key);

  @override
  State<FolderPickerDialog> createState() => _FolderPickerDialogState();
}

class _FolderPickerDialogState extends State<FolderPickerDialog> {
  String cwd = "/";

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).background,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.fromBorderSide(BorderSide(color: Theme.of(context).highlight, width: 1)),
            ),
            width: size.maxWidth / 3,
            height: size.maxHeight / 1.25,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: AdwButton.circular(
                          size: 28.0,
                          backgroundColor: const Color(0xFFFFFFFF),
                          padding: const EdgeInsets.all(4.0),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const AdwaitaIcon(
                            AdwaitaIcons.window_close,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),

                    // Folder List
                    Expanded(
                      child: FsTreeView(
                        cwd: cwd,
                        onChange: (value) => setState(() => cwd = value),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: AdwButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: AdwButton(
                              opaque: true,
                              backgroundColor: Colors.suggested,
                              onPressed: () {
                                Navigator.of(context).pop(cwd);
                              },
                              child: const Text("Open"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Open Folder",
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
