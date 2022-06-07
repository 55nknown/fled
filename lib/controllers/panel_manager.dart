import 'package:fled/panels/explorer_panel.dart';
import 'package:fled/panels/panel_layout.dart';
import 'package:fled/panels/empty_panel.dart';
import 'package:flutter/widgets.dart';

class PanelManager extends ChangeNotifier {
  PanelLayout layout = VerticalLayout(children: [
    HorizontalLayout(children: [
      VerticalLayout(children: [
        SingleLayout(panel: EmptyPanel()),
        SingleLayout(panel: EmptyPanel()),
        SingleLayout(panel: EmptyPanel()),
      ]),
      VerticalLayout(children: [
        HorizontalLayout(children: [
          SingleLayout(panel: EmptyPanel()),
          SingleLayout(panel: EmptyPanel()),
        ]),
        HorizontalLayout(children: [
          SingleLayout(panel: EmptyPanel()),
        ]),
        SingleLayout(panel: EmptyPanel()),
        HorizontalLayout(children: [
          SingleLayout(panel: EmptyPanel()),
          SingleLayout(panel: EmptyPanel()),
          SingleLayout(panel: EmptyPanel()),
        ]),
      ]),
      VerticalLayout(children: [
        SingleLayout(panel: EmptyPanel()),
        SingleLayout(panel: EmptyPanel()),
        SingleLayout(panel: EmptyPanel()),
        SingleLayout(panel: EmptyPanel()),
        SingleLayout(panel: EmptyPanel()),
      ])
    ]),
    SingleLayout(panel: EmptyPanel()),
  ]);
}
