import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_button.dart';
import 'package:flutter/material.dart';

//! This feature is not ready, will be implemented later.
class LoginPageForgotPasswordButton extends StatelessWidget {
  const LoginPageForgotPasswordButton();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BouncingButton(
          child: Text(
            'login.forgot_password_button_text'.tr(),
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: context.colors.textSecondary),
          ),
          onTap: () {
            // TODO(Furkan): forgot passsword onTap
          },
        )
      ],
    );
  }
}
