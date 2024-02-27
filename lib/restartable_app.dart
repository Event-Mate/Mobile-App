import 'package:flutter/material.dart';

class RestartableApp extends StatefulWidget {
  const RestartableApp({required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartableAppState>()?.restartApp();
  }

  @override
  _RestartableAppState createState() => _RestartableAppState();
}

class _RestartableAppState extends State<RestartableApp> {
  Key key = UniqueKey();

  void restartApp() => setState(() => key = UniqueKey());

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
