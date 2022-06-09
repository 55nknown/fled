import 'package:fled/ui/dialogs/dialog_builder.dart';
import 'package:fled/ui/panels/panel_builder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' as material;

class Frame extends StatelessWidget {
  const Frame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return material.Theme(
      data: material.ThemeData.dark(),
      child: material.Material(
        type: material.MaterialType.transparency,
        child: Navigator(
          onGenerateRoute: (settings) => PageRouteBuilder(
            pageBuilder: (context, _, __) => Stack(
              children: const [
                PanelBuilder(),
                DialogBuilder(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
