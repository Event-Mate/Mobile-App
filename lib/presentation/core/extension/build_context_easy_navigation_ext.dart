import 'package:flutter/material.dart';

extension EasyNavigationExt on BuildContext {
  Future<void> openPage(Widget page) async {
    await Navigator.of(this).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  Future<void> openPageWithReplacement(Widget page) async {
    await Navigator.of(this).pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  Future<void> openPageWithClearStack(Widget page) async {
    await Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  Future<void> openNamedPage(String routeName) async {
    await Navigator.of(this).pushNamed(routeName);
  }

  Future<void> openNamedPageWithReplacement(String routeName) async {
    await Navigator.of(this).pushReplacementNamed(routeName);
  }

  Future<void> openNamedPageWithClearStack(String routeName) async {
    await Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
    );
  }

// TODO(Furkan): maybe we can implement this lateron
  // Future<void> popTillRoot() async {
  //   return Navigator.popUntil(this, ModalRoute.withName(AppRoutes.ROOT.value));
  // }
}
