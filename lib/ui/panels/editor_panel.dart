import 'package:fled/theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class EditorPanelWidget extends StatefulWidget {
  const EditorPanelWidget({Key? key}) : super(key: key);

  @override
  State<EditorPanelWidget> createState() => _EditorPanelWidgetState();
}

class _EditorPanelWidgetState extends State<EditorPanelWidget> {
  String buffer = "";
  Offset cursor = const Offset(0, 0);

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

  int _cursorOffset() {
    int offset = (cursor.dx + cursor.dy).toInt();
    final lines = buffer.split("\n");

    for (int i = 0; i < cursor.dy; i++) {
      offset += lines[i].length;
    }

    return offset;
  }

  void _onKey(RawKeyEvent event) {
    if (event is RawKeyUpEvent) return;

    if (event is RawKeyDownEvent) {
      if (event.data.logicalKey == LogicalKeyboardKey.enter) {
        cursor = Offset(0, cursor.dy + 1);
        setState(() => buffer += "\n");
        return;
      } else if (event.data.logicalKey == LogicalKeyboardKey.backspace) {
        if (buffer.isNotEmpty) {
          cursor += Offset(-1, buffer[_cursorOffset()] == "\n" ? -1 : 0);
          setState(() => buffer = buffer.substring(0, buffer.length - 1));
        }
        return;
      } else if (event.data.logicalKey == LogicalKeyboardKey.arrowUp) {
        setState(() => cursor += const Offset(0, -1));
        return;
      } else if (event.data.logicalKey == LogicalKeyboardKey.arrowDown) {
        setState(() => cursor += const Offset(0, 1));
        return;
      } else if (event.data.logicalKey == LogicalKeyboardKey.arrowRight) {
        setState(() => cursor += const Offset(1, 0));
        return;
      } else if (event.data.logicalKey == LogicalKeyboardKey.arrowLeft) {
        setState(() => cursor += const Offset(-1, 0));
        return;
      }
    }

    cursor += const Offset(1, 0);
    setState(() => buffer += event.character ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: EditorPainter(buffer: buffer, cursor: cursor, theme: Theme.of(context)),
        ),
      ),
    );
  }
}

class EditorPainter extends CustomPainter {
  EditorPainter({required this.buffer, required this.theme, required this.cursor});

  String buffer;
  Offset cursor;
  final ThemeData theme;

  @override
  void paint(Canvas canvas, Size size) {
    final lines = buffer.split("\n");

    final text = TextPainter(
      textAlign: TextAlign.right,
      text: TextSpan(
          text: [...List.generate(lines.length, (index) => "${index + 1}"), " " * 4].join("\n"),
          style: TextStyle(fontFamilyFallback: theme.fonts, fontSize: 16.0, color: theme.muted)),
      textDirection: TextDirection.ltr,
    );
    text.layout();
    text.paint(canvas, const Offset(24.0, 12.0));

    final btext = TextPainter(
      text: TextSpan(text: buffer, style: TextStyle(fontFamilyFallback: theme.fonts, fontSize: 16.0, color: theme.foreground)),
      textDirection: TextDirection.ltr,
    );
    btext.layout();
    btext.paint(canvas, Offset(24 + text.width + 12, 12));

    final ltext = TextPainter(
      text: TextSpan(
          text: lines[cursor.dy.toInt()].substring(0, cursor.dx.toInt()),
          style: TextStyle(fontFamilyFallback: theme.fonts, fontSize: 16.0, color: theme.foreground)),
      textDirection: TextDirection.ltr,
    );
    ltext.layout();

    canvas.drawRect(Rect.fromLTWH(24 + text.width + 12 + ltext.width, 12 + ltext.height * cursor.dy, 4, 20), Paint()..color = Colors.suggested);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
