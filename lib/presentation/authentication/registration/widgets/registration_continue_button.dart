import 'package:event_mate/presentation/core/widgets/splashing_button.dart';
import 'package:event_mate/presentation/extension/build_context_theme_ext.dart';
import 'package:flutter/material.dart';

class RegistrationContinueButton extends StatelessWidget {
  const RegistrationContinueButton({required this.onTap, this.enabled = true});
  final VoidCallback onTap;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return SplashingButton(
      onTap: enabled ? onTap : null,
      decoration: BoxDecoration(
        color: enabled ? context.colors.primary : context.colors.disabled,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Icon(
          Icons.arrow_forward_ios,
          color:
              enabled ? context.colors.background : context.colors.textDisabled,
        ),
      ),
    );
  }
}
