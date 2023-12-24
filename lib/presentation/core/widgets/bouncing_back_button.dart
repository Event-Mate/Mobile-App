import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_button.dart';
import 'package:flutter/material.dart';

class BouncingBackButton extends StatelessWidget {
  const BouncingBackButton({super.key, this.color, this.onTap, this.size = 30});
  final Color? color;
  final VoidCallback? onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return BouncingButton(
      onTap: onTap ?? () => Navigator.of(context).pop(),
      child: Icon(
        Icons.chevron_left,
        size: size,
        color: color ?? context.colors.textPrimary,
      ),
    );
  }
}
