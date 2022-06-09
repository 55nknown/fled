import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: constant_identifier_names
enum IconPack { Angular, Nest, Ngrx, React, Redux, Vue, Vuex }

class FsIcon extends StatelessWidget {
  const FsIcon(this.entry, {Key? key}) : super(key: key);

  final FileSystemEntity entry;

  @override
  Widget build(BuildContext context) {
    if (entry.statSync().type == FileSystemEntityType.directory) {
      return SvgPicture.asset("assets/icons/folder.svg");
    }
    return SvgPicture.asset("assets/icons/file.svg");
  }
}
