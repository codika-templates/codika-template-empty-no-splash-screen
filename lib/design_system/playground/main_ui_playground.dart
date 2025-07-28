import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'router/playground_router.dart';

void main() {
  runApp(const DesignSystemPlaygroundApp());
}

class DesignSystemPlaygroundApp extends StatelessWidget {
  const DesignSystemPlaygroundApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = PlaygroundRouter();
    
    return MaterialApp.router(
      title: 'Design System Playground',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerDelegate: router.delegate(),
      routeInformationParser: router.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
    );
  }
}