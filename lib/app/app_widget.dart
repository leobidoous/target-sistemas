import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/themes/app_theme.dart';
import 'core/themes/theme_factory.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    super.initState();
    AppTheme.initAppThemes();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Target Sistemas',
      themeMode: ThemeMode.light,
      theme: ThemeFactory.light(),
      darkTheme: ThemeFactory.dark(),
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
    );
  }
}
