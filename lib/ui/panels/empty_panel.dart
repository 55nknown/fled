import 'package:fled/theme.dart';
import 'package:flutter/widgets.dart';

class EmptyPanel extends StatelessWidget {
  const EmptyPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        ">/<",
        style: TextStyle(
          fontSize: 42.0,
          fontFamilyFallback: Theme.of(context).fonts,
          color: Theme.of(context).muted,
        ),
      ),
    );
  }
}
