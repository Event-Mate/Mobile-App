import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/widgets/splashing_button.dart';
import 'package:flutter/material.dart';

class LoginPageSignInButton extends StatelessWidget {
  const LoginPageSignInButton();
  @override
  Widget build(BuildContext context) {
    return SplashingButton(
      onTap: () {
        // TODO(Furkan): on tap
        // context.read<PasswordEditBloc>().addPasswordValidate();
      },
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: context.colors.primary,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.outer,
            color: context.colors.accent.withOpacity(.6),
            blurRadius: 10,
          ),
        ],
      ),
      child: Text(
        // TODO(Furkan): translate
        'Sign In',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: context.colors.background,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
