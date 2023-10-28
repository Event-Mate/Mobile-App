import 'package:event_mate/presentation/extension/build_context_theme_ext.dart';
import 'package:flutter/material.dart';

class RegistrationProgressCircle extends StatelessWidget {
  const RegistrationProgressCircle({this.completed = false});
  final bool completed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: completed ? context.colors.primary : context.colors.background,
        border: Border.all(color: context.colors.textPrimary),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
