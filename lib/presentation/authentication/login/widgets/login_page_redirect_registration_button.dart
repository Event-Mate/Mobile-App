import 'package:easy_localization/easy_localization.dart';
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
          '${'login.dont_have_account_button_text'.tr()} ',
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: context.colors.textSecondary),
        ),
        BouncingButton(
          child: Text(
            'login.redirect_to_registration_button_text'.tr(),
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: context.colors.primary),
          ),
          onTap: () {
            context.openPageWithReplacement(const RegistrationPage());
          },
        )
      ],
    );
  }
}
