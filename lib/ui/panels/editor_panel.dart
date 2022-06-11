import 'dart:convert';

import 'package:fled/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class EditorPanelWidget extends StatefulWidget {
  const EditorPanelWidget({Key? key}) : super(key: key);

  @override
  State<EditorPanelWidget> createState() => _EditorPanelWidgetState();
}

class _EditorPanelWidgetState extends State<EditorPanelWidget> {
  final ValueNotifier<List<int>> buffer = ValueNotifier([]);
  final ValueNotifier<Offset> scrollOffset = ValueNotifier(Offset.zero);

  @override
  void initState() {
    super.initState();
    RawKeyboard.instance.addListener(_onKey);
  }

  @override
  void dispose() {
    RawKeyboard.instance.removeListener(_onKey);
    super.dispose();
  }

  void _onKey(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.data.logicalKey == LogicalKeyboardKey.enter) {
        buffer.value += utf8.encode("\n");
        return;
      }

      if (event.data.logicalKey == LogicalKeyboardKey.backspace) {
        buffer.value = buffer.value.sublist(0, buffer.value.length - 1);
        return;
      }
    }

    if (event.character != null) buffer.value += utf8.encode(event.character!);
  }

  bool checkScroll(PointerScrollEvent event) {
    if ((scrollOffset.value - event.scrollDelta).dx > 0) {
      scrollOffset.value = Offset(0, scrollOffset.value.dy);
      return false;
    }

    if ((scrollOffset.value - event.scrollDelta).dy > 0) {
      scrollOffset.value = Offset(scrollOffset.value.dx, 0);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Listener(
        onPointerSignal: (event) {
          if (event is PointerScrollEvent && checkScroll(event)) {
            scrollOffset.value -= event.scrollDelta;
          }
        },
        child: SizedBox.expand(
          child: ValueListenableBuilder(
              valueListenable: buffer,
              builder: (context, value, child) {
                return ValueListenableBuilder(
                  valueListenable: scrollOffset,
                  builder: (context, value, child) {
                    return CustomPaint(
                      painter: EditorPainter(text: utf8.decode(buffer.value), offset: scrollOffset.value, theme: Theme.of(context)),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}

class EditorPainter extends CustomPainter {
  EditorPainter({this.text = "", this.offset = Offset.zero, required this.theme});

  ThemeData theme;
  String text;
  Offset offset;
  static const Offset padding = Offset(6.0, 12.0);
  static const Offset textPadding = Offset(12.0, 0.0);

  TextPainter lineNumbersLayout(Canvas canvas, Size size) {
    final lineNumberPainter = TextPainter(
      text: TextSpan(
        text: "${List.generate(text.split("\n").length, (i) => "${i + 1}").join("\n")}\n${" " * 5}",
        style: TextStyle(fontFamilyFallback: theme.fonts, color: theme.muted),
      ),
      textAlign: TextAlign.right,
      textDirection: TextDirection.ltr,
    );
    lineNumberPainter.layout();

    return lineNumberPainter;
  }

  void lineNumbersPaint(Canvas canvas, Size size, TextPainter lineNumbersPainter) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, lineNumbersPainter.width + padding.dx + textPadding.dx, size.height),
      Paint()..color = theme.background,
    );
    lineNumbersPainter.paint(canvas, Offset(0.0, offset.dy) + padding);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final lineNumbersPainter = lineNumbersLayout(canvas, size);

    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontFamilyFallback: theme.fonts, fontWeight: FontWeight.w300),
      ),
      textDirection: TextDirection.ltr,
    );
    painter.layout();
    painter.paint(canvas, offset + Offset(lineNumbersPainter.width, 0.0) + padding + textPadding);

    lineNumbersPaint(canvas, size, lineNumbersPainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
