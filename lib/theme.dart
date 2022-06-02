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

  final red = const Color(0xFFF01044);
  final pink = const Color(0xFFFF375F);
  final purple = const Color(0xFF6F6DF0);
  final blue = const Color(0xFF0084FF);
  final teal = const Color(0xFF00B8A3);
  final green = const Color(0xFF4DBB5F);
  final yellow = const Color(0xFFFAD075);
  final orange = const Color(0xFFFF8500);
}

class CodeTheme {
  const CodeTheme();

  final token1 = const Color(0xFFC678DD);
  final token2 = const Color(0xFFE06C75);
  final token3 = const Color(0xFF98C379);
  final token4 = const Color(0xFFE5C07B);
  final token5 = const Color(0xFF61AFEF);
  final token6 = const Color(0xFF54AFBB);
  final token7 = const Color(0xFFABB2BF);
}
