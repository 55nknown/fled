import 'package:fled/input/keyboard.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Providers {
  final keyboardInput = KeyboardInput();
  late final Provider _keyboardInputProvider;

  Providers() {
    _keyboardInputProvider = Provider(create: (_) => keyboardInput);
  }

  List<SingleChildWidget> toList() {
    return [_keyboardInputProvider];
  }
}
