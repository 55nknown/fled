import 'package:fled/controllers/panel_manager.dart';
import 'package:fled/exceptions.dart';
import 'package:fled/panels/panel_layout.dart';
import 'package:fled/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class PanelBuilder extends StatelessWidget {
  const PanelBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PanelManager>(
      builder: (context, value, child) {
        return Row(
          children: [
            _buildLayout(context, value.layout),
          ],
        );
      },
    );
  }

  Widget _buildLayout(BuildContext context, PanelLayout layout) {
    Widget? child;

    if (layout is SingleLayout) {
      child = layout.panel.child ?? const SizedBox();
    } else if (layout is HorizontalLayout) {
      child = Row(children: _insertDividers(context, layout.children.map((l) => _buildLayout(context, l)), Axis.horizontal));
    } else if (layout is VerticalLayout) {
      child = Column(children: _insertDividers(context, layout.children.map((l) => _buildLayout(context, l)), Axis.vertical));
    }

    if (child != null) {
      return Expanded(
        flex: layout.flex,
        child: child,
      );
    }

    throw UnknownPanelLayout();
  }

  List<Widget> _insertDividers(BuildContext context, Iterable<Widget> children, Axis axis) {
    List<Widget> result = [];
    const strokeWidth = 2.0;

    for (int i = 0; i < children.length * 2 - 1; i++) {
      if (i % 2 == 0) {
        result.add(children.elementAt((i / 2).floor()));
      } else {
        result.add(Container(
          height: axis == Axis.horizontal ? double.infinity : strokeWidth,
          width: axis == Axis.horizontal ? strokeWidth : double.infinity,
          color: Theme.of(context).stroke,
        ));
      }
    }

    return result;
  }
}
