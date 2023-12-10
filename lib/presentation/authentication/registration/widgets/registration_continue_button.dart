import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/widgets/splashing_button.dart';
import 'package:flutter/material.dart';

class RegistrationContinueButton extends StatelessWidget {
  const RegistrationContinueButton({required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return SplashingButton(
      onTap: onTap,
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: context.colors.primary,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Icon(Icons.arrow_forward_ios, color: context.colors.background),
    );
  }
}
