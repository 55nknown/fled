import 'package:fled/ui/dialogs/dialog_transition.dart';
import 'package:flutter/widgets.dart';

class DialogController {
  static Future<T?> openDialog<T extends Object?>({required BuildContext context, required Widget child}) {
    return Navigator.of(context).push<T>(DialogRoute(child: child));
  }
}
