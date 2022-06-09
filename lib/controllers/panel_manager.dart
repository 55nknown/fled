import 'package:fled/panels/editor_panel.dart';
import 'package:fled/panels/explorer_panel.dart';
import 'package:fled/panels/panel_layout.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

class PanelManager extends ChangeNotifier {
  final PanelLayout _layout = HorizontalLayout(children: [
    SingleLayout(panel: ExplorerPanel()),
    SingleLayout(panel: EditorPanel()),
  ]);

  PanelLayout get layout => _layout;

  PanelManager() {
    _assignId(_layout);
  }

  void _assignId(PanelLayout panel) {
    String id = const Uuid().v4();

    panel.id = id;

    if (panel is HorizontalLayout) {
      for (var child in panel.children) {
        _assignId(child);
      }
    } else if (panel is VerticalLayout) {
      for (var child in panel.children) {
        _assignId(child);
      }
    }
  }

  void resize(PanelLayout panel) {
    notifyListeners();
  }
}
