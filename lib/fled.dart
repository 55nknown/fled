import 'dart:ui';

import 'package:fled/providers.dart';
import 'package:fled/theme.dart';
import 'package:fled/ui/frame.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Fled extends StatelessWidget {
  const Fled({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: const Locale("en", "US"),
      delegates: const [
        DefaultWidgetsLocalizations.delegate,
      ],
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: MediaQuery(
          data: MediaQueryData.fromWindow(window),
          child: _providerBuilder(context),
        ),
      ),
    );
  }

  Widget _providerBuilder(BuildContext context) {
    final providers = Providers();

    return MultiProvider(
      providers: providers.toList(),
      child: RawKeyboardListener(
        // Global keyboard handler
        onKey: providers.keyboardInput.registerHandler(),
        focusNode: FocusNode(),
        child: _themedBuilder(context),
      ),
    );
  }

  Widget _themedBuilder(BuildContext context) {
    return Theme(
      child: Builder(
        builder: (context) {
          return DecoratedBox(
            decoration: BoxDecoration(color: Theme.of(context).background),
            child: const Frame(),
          );
        },
      ),
    );
  }
}
