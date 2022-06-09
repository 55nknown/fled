import 'package:fled/controllers/panel_manager.dart';
import 'package:fled/exceptions.dart';
import 'package:fled/panels/panel_layout.dart';
import 'package:fled/ui/divider.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class PanelBuilder extends StatelessWidget {
  const PanelBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final layout = Provider.of<PanelManager>(context).layout;

    return _layoutBuilder(layout);
  }

  Widget _layoutBuilder(PanelLayout layout) {
    if (layout is SingleLayout) {
      return SizedBox(
        width: layout.width,
        height: layout.height,
        child: layout.panel.child,
      );
    } else if (layout is HorizontalLayout) {
      return SizedBox(
        width: layout.width,
        height: layout.height,
        child: _sizedLayoutBuilder(layout),
      );
    } else if (layout is VerticalLayout) {
      return SizedBox(
        width: layout.width,
        height: layout.height,
        child: _sizedLayoutBuilder(layout),
      );
    }

    throw UnknownPanelLayout();
  }

  PanelLayout _fillLayout(PanelLayout layout, Size size) {
    if (layout is HorizontalLayout) {
      final used = layout.children.map((l) => l.width ?? 0.0).fold<double>(0, (a, b) => a + b);
      double remaining = size.width - used;

      for (int i = 0; i < layout.children.length; i++) {
        final child = layout.children[i];
        if (child.width == null) {
          final allocated = i == layout.children.length - 1 ? remaining : remaining / 2;
          child.width = allocated;
          remaining -= allocated;
        }
      }

      return layout;
    } else if (layout is VerticalLayout) {
      final used = layout.children.map((l) => l.height ?? 0.0).fold<double>(0, (a, b) => a + b);
      double remaining = size.height - used;

      for (int i = 0; i < layout.children.length; i++) {
        final child = layout.children[i];
        if (child.height == null) {
          final allocated = i == layout.children.length - 1 ? remaining : remaining / 2;
          child.height = allocated;
          remaining -= allocated;
        }
      }

      return layout;
    } else {
      throw UnknownPanelLayout();
    }
  }

  Widget _dragDividerBuilder(PanelLayout layout) {
    const halfDivider = (Divider.deadSpace + Divider.strokeWidth) / 2;

    if (layout is HorizontalLayout) {
      if (layout.children.length < 2) return const SizedBox();

      return Row(
        children: List.generate(
          layout.children.length * 2 - 1,
          (index) => index % 2 == 0
              ? SizedBox(width: layout.children[index ~/ 2].width! - halfDivider * (index == 0 ? 1 : 2))
              : const Divider(direction: Axis.vertical),
        ),
      );
    } else if (layout is VerticalLayout) {
      if (layout.children.length < 2) return const SizedBox();

      return Column(
        children: List.generate(
          layout.children.length * 2 - 1,
          (i) => i % 2 == 0
              ? SizedBox(height: layout.children[i ~/ 2].height! - halfDivider * (i == 0 ? 1 : 2))
              : const Divider(direction: Axis.vertical),
        ),
      );
    } else {
      throw UnknownPanelLayout();
    }
  }

  Widget _sizedLayoutBuilder(PanelLayout layout) {
    return LayoutBuilder(builder: (context, constraints) {
      final size = Size(constraints.maxWidth, constraints.maxHeight);

      if (layout is HorizontalLayout) {
        final filled = _fillLayout(layout, size) as HorizontalLayout;

        return Stack(
          children: [
            Row(children: filled.children.map((e) => _layoutBuilder(e)).toList()),
            GestureDetector(
              onHorizontalDragUpdate: (event) {
                event.localPosition;

                var localChild = filled.children.first;
                if (localChild.width! + event.delta.dx > 0 && size.width > localChild.width! + event.delta.dx) {
                  localChild.width = localChild.width! + event.delta.dx;
                  for (var child in filled.children) {
                    if (child == localChild) continue;
                    child.width = null;
                  }
                  Provider.of<PanelManager>(context, listen: false).resize(localChild);
                }
              },
              child: _dragDividerBuilder(filled),
            ),
          ],
        );
      } else if (layout is VerticalLayout) {
        final filled = _fillLayout(layout, size) as VerticalLayout;

        return Stack(
          children: [
            Column(children: filled.children.map((e) => _layoutBuilder(e)).toList()),
            GestureDetector(
              onVerticalDragUpdate: (event) {
                print(event);
              },
              child: _dragDividerBuilder(filled),
            ),
          ],
        );
      } else {
        throw UnknownPanelLayout();
      }
    });
  }
}
