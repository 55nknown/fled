import 'package:fled/panels/panel.dart';

abstract class PanelLayout {
  PanelLayout({this.width, this.height});

  double? width;
  double? height;
  late String id;
}

class SingleLayout extends PanelLayout {
  SingleLayout({required this.panel});

  Panel panel;
}

class HorizontalLayout extends PanelLayout {
  HorizontalLayout({required this.children});

  List<PanelLayout> children;
}

class VerticalLayout extends PanelLayout {
  VerticalLayout({required this.children});

  List<PanelLayout> children;
}
