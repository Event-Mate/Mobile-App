import 'dart:io';

import 'package:event_mate/presentation/extension/build_context_theme_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    this.color,
    this.size = 28,
    this.androidStrokeWidth = 4,
  });

  final Color? color;
  final double size;
  final double androidStrokeWidth;

  @override
  Widget build(BuildContext context) {
    final indicatorColor = color ?? context.colors.accent;
    if (Platform.isIOS) {
      return CupertinoActivityIndicator(
        radius: size / 2,
        color: indicatorColor,
      );
    } else {
      return SizedBox(
        height: size,
        width: size,
        child: Center(
          child: SizedBox(
            height: size,
            width: size,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
              strokeWidth: androidStrokeWidth,
            ),
          ),
        ),
      );
    }
  }
}
