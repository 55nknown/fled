import 'dart:io';

import 'package:fled/ui/icons/icon_pack.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/widgets.dart';

class FsEntryItem extends StatelessWidget {
  const FsEntryItem(this.entry, {Key? key, this.onPressed}) : super(key: key);

  final FileSystemEntity entry;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: AdwButton.flat(
        onPressed: onPressed,
        child: Row(
          children: [
            FsIcon(entry),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  path.basename(entry.path),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
