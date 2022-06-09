import 'package:flutter/widgets.dart';

class EditorEnvironment extends ChangeNotifier {
  String? _workingDirectory;

  String? get workingDirectory => _workingDirectory;

  void setWorkingDirectory(String value) {
    _workingDirectory = value;
    notifyListeners();
  }
}
