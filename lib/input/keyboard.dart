import 'package:flutter/widgets.dart';

typedef Handler = ValueChanged<RawKeyEvent>;

class KeyboardInput {
  final List<Handler> _receivers = [];

  void _dispatchEvent(RawKeyEvent event) {
    for (var receiver in _receivers) {
      receiver(event);
    }
  }

  void registerReceiver(Handler handler) {
    _receivers.add(handler);
  }

  void removeReceiver(Handler handler) {
    _receivers.remove(handler);
  }

  Handler registerHandler() => _dispatchEvent;
}
