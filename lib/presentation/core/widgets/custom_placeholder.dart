import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:flutter/material.dart';

class CustomPlaceholder extends StatelessWidget {
  const CustomPlaceholder();
  @override
  Widget build(BuildContext context) =>
      Container(color: context.colors.surfaceSecondary);
}
