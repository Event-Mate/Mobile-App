import 'package:event_mate/presentation/authentication/registration/registration_page.dart';
import 'package:event_mate/presentation/core/extension/build_context_easy_navigation_ext.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_button.dart';
import 'package:flutter/material.dart';

class LoginPageRedirectRegistrationButton extends StatelessWidget {
  const LoginPageRedirectRegistrationButton();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          // TODO(Furkan): Translate this text
          'Don’t have an account? ',
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: context.colors.textSecondary),
        ),
        BouncingButton(
          child: Text(
            // TODO(Furkan): Translate this text
            'Sign Up',
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: context.colors.primary),
          ),
          onTap: () {
            context.openPage(const RegistrationPage());
          },
        )
      ],
    );
  }
}
