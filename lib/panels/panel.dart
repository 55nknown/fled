import 'package:flutter/widgets.dart';

abstract class Panel {
  Widget? get child;
  Widget? get icon => null;
  String get title => "Panel";
}