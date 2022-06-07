import 'package:fled/panels/panel.dart';

abstract class PanelLayout {
  PanelLayout({this.flex = 1});

  int flex;
}

class SingleLayout extends PanelLayout {
  SingleLayout({required this.panel, int flex = 1}) : super(flex: flex);

  Panel panel;
}

class HorizontalLayout extends PanelLayout {
  HorizontalLayout({required this.children, int flex = 1}) : super(flex: flex);

  List<PanelLayout> children;
}

class VerticalLayout extends PanelLayout {
  VerticalLayout({required this.children, int flex = 1}) : super(flex: flex);

  List<PanelLayout> children;
}
