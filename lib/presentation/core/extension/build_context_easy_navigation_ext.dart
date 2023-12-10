import 'package:flutter/material.dart';

extension EasyNavigationExt on BuildContext {
  void openPage(Widget page) {
    Navigator.of(this).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  void openPageWithReplacement(Widget page) {
    Navigator.of(this).pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  void openPageWithClearStack(Widget page) {
    Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  void openNamedPage(String routeName) {
    Navigator.of(this).pushNamed(routeName);
  }

  void openNamedPageWithReplacement(String routeName) {
    Navigator.of(this).pushReplacementNamed(routeName);
  }

  void openNamedPageWithClearStack(String routeName) {
    Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
    );
  }
}
