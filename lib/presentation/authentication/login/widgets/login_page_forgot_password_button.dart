import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_button.dart';
import 'package:flutter/material.dart';

class LoginPageForgotPasswordButton extends StatelessWidget {
  const LoginPageForgotPasswordButton();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BouncingButton(
          child: Text(
            // TODO(Furkan): Translate this text
            'Forgot password?',
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: context.colors.textSecondary),
          ),
          onTap: () {
            // TODO(Furkan): forgot passswrod on tap
          },
        )
      ],
    );
  }
}
