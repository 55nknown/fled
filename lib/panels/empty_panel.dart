import 'package:fled/panels/panel.dart';
import 'package:fled/ui/panels/empty_panel.dart';
import 'package:flutter/widgets.dart';

class EmptyPanel extends Panel {
  @override
  Widget? get child => const EmptyPanelWidget();

  @override
  String get title => "Empty";
}
