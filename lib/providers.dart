import 'package:fled/controllers/panel_manager.dart';
import 'package:fled/input/keyboard.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Providers {
  final keyboardInput = KeyboardInput();
  late final Provider _keyboardInputProvider;

  final panelManager = PanelManager();
  late final ChangeNotifierProvider _panelManagerProvider;

  Providers() {
    _keyboardInputProvider = Provider<KeyboardInput>(create: (_) => keyboardInput);
    _panelManagerProvider = ChangeNotifierProvider<PanelManager>(create: (_) => panelManager);
  }

  List<SingleChildWidget> toList() {
    return [_keyboardInputProvider, _panelManagerProvider];
  }
}
