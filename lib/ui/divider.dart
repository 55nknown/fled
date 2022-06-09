import 'package:fled/theme.dart';
import 'package:flutter/widgets.dart';

class Divider extends StatefulWidget {
  const Divider({Key? key, required this.direction}) : super(key: key);

  final Axis direction;

  static const strokeWidth = 2.0;
  static const deadSpace = 4.0;

  @override
  State<Divider> createState() => _DividerState();
}

class _DividerState extends State<Divider> with SingleTickerProviderStateMixin {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 200);

    return MouseRegion(
      cursor: SystemMouseCursors.resizeColumn,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: duration,
        width: widget.direction == Axis.vertical ? Divider.strokeWidth + Divider.deadSpace : double.infinity,
        height: widget.direction == Axis.horizontal ? Divider.strokeWidth + Divider.deadSpace : double.infinity,
        color: const Color(0xFF555555).withOpacity(_hover ? 1.0 : 0.0),
        child: Align(
          alignment: Alignment.center,
          child: AnimatedContainer(
            duration: duration,
            width: widget.direction == Axis.vertical ? Divider.strokeWidth : double.infinity,
            height: widget.direction == Axis.horizontal ? Divider.strokeWidth : double.infinity,
            color: _hover ? const Color(0xFF555555) : Theme.of(context).stroke,
          ),
        ),
      ),
    );
  }
}
