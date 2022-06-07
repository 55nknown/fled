import 'package:fled/panels/panel.dart';
import 'package:fled/ui/panels/explorer_panel.dart';
import 'package:flutter/widgets.dart';

class ExplorerPanel extends Panel {
  @override
  Widget? get child => const ExplorerPanelWidget();

  @override
  String get title => "Explorer";
}
