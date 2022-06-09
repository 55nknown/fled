import 'package:fled/panels/panel.dart';
import 'package:fled/ui/panels/editor_panel.dart';
import 'package:flutter/widgets.dart';

class EditorPanel extends Panel {
  @override
  Widget? get child => const EditorPanelWidget();

  @override
  String get title => "Editor";
}
