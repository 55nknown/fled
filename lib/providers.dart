import 'package:fled/controllers/editor_environment.dart';
import 'package:fled/controllers/panel_manager.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Providers {
  final panelManager = PanelManager();
  late final ChangeNotifierProvider _panelManagerProvider;

  late final ChangeNotifierProvider _editorEnvironment;

  Providers() {
    _panelManagerProvider = ChangeNotifierProvider<PanelManager>(create: (_) => panelManager);
    _editorEnvironment = ChangeNotifierProvider<EditorEnvironment>(create: (_) => EditorEnvironment());
  }

  List<SingleChildWidget> toList() {
    return [_panelManagerProvider, _editorEnvironment];
  }
}
