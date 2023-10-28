import 'package:event_mate/presentation/core/widgets/bouncing_button.dart';
import 'package:event_mate/presentation/extension/build_context_theme_ext.dart';
import 'package:flutter/material.dart';

class BouncingBackButton extends StatelessWidget {
  const BouncingBackButton({super.key, this.color, this.onTap});
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BouncingButton(
      onTap: onTap ?? () => Navigator.of(context).pop(),
      child: Icon(
        Icons.chevron_left,
        size: 30,
        color: color ?? context.colors.textPrimary,
      ),
    );
  }
}
