import 'package:flutter/widgets.dart';

class Theme extends InheritedWidget {
  const Theme({Key? key, required final Widget child, this.data = const ThemeData()}) : super(key: key, child: child);

  final ThemeData data;

  static ThemeData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Theme>()!.data;
  }

  @override
  bool updateShouldNotify(Theme oldWidget) {
    return oldWidget.data != data;
  }
}

class ThemeData {
  const ThemeData();

  final highlight = const Color(0xFF303030);
  final background = const Color(0xFF242424);
  final foreground = const Color(0xFFFFFFFF);
  final muted = const Color(0xFF707070);
  final stroke = const Color(0xFF2C2C2C);
  final colors = const Colors();
  final code = const CodeTheme();
  final fonts = const ["Cascadia Code", "Fira Code", "monospace"];
}

class Colors {
  const Colors();

  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);

  static const red = Color(0xFFF01044);
  static const pink = Color(0xFFFF375F);
  static const purple = Color(0xFF6F6DF0);
  static const blue = Color(0xFF0084FF);
  static const teal = Color(0xFF00B8A3);
  static const green = Color(0xFF4DBB5F);
  static const yellow = Color(0xFFFAD075);
  static const orange = Color(0xFFFF8500);

  static const suggested = Color(0xFF5A9BE9);
  static const destructive = Color(0xFFE01B24);
}

class CodeTheme {
  const CodeTheme();

  static const token1 = Color(0xFFC678DD);
  static const token2 = Color(0xFFE06C75);
  static const token3 = Color(0xFF98C379);
  static const token4 = Color(0xFFE5C07B);
  static const token5 = Color(0xFF61AFEF);
  static const token6 = Color(0xFF54AFBB);
  static const token7 = Color(0xFFABB2BF);
}
