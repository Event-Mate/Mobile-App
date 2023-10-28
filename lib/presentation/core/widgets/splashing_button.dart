import 'package:event_mate/presentation/extension/build_context_theme_ext.dart';
import 'package:flutter/material.dart';

class SplashingButton extends StatelessWidget {
  const SplashingButton({
    required this.onTap,
    required this.child,
    this.decoration,
    this.width,
    this.height,
    this.padding,
  });

  final Widget child;
  final VoidCallback onTap;
  final BoxDecoration? decoration;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      focusColor: context.colors.primary,
      borderRadius: decoration?.borderRadius as BorderRadius?,
      child: Ink(
        width: width,
        height: height,
        padding: padding,
        decoration: decoration,
        child: Center(child: child),
      ),
    );
  }
}
