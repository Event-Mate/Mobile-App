import 'package:event_mate/presentation/authentication/login/login_page.dart';
import 'package:event_mate/presentation/authentication/login/widgets/login_page_redirect_registration_button.dart';
import 'package:event_mate/presentation/authentication/login/widgets/login_page_sign_in_button.dart';
import 'package:flutter/material.dart';

class LoginPageForm extends StatelessWidget {
  const LoginPageForm();
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          LoginPageEmailInput(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: LoginPagePasswordInput(),
          ),
          // TODO(Furkan): Uncomment below after developing this feature.
          // LoginPageForgotPasswordButton(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: LoginPageSignInButton(),
          ),
          LoginPageRedirectRegistrationButton(),
        ],
      ),
    );
  }
}
