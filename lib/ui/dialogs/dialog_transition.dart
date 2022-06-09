import 'package:flutter/widgets.dart';

class DialogRoute<T> extends ModalRoute<T> {
  DialogRoute({required Widget child}) : _child = child;

  final Widget _child;

  @override
  Color? get barrierColor => const Color(0x7f000000);

  @override
  bool get barrierDismissible => false;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 150);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return _child;
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    const curve = Curves.easeInOut;

    final tween = Tween(begin: const Offset(0, -0.05), end: const Offset(0, 0)).chain(CurveTween(curve: curve));
    final offset = animation.drive(tween);
    final opacity = CurvedAnimation(parent: animation, curve: curve);

    return FadeTransition(
      opacity: opacity,
      child: SlideTransition(
        position: offset,
        child: child,
      ),
    );
  }
}
