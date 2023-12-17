import 'package:event_mate/presentation/authentication/login/widgets/login_page_forgot_password_button.dart';
import 'package:event_mate/presentation/authentication/login/widgets/login_page_header.dart';
import 'package:event_mate/presentation/authentication/login/widgets/login_page_redirect_registration_button.dart';
import 'package:event_mate/presentation/authentication/login/widgets/login_page_sign_in_button.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_button.dart';
import 'package:event_mate/presentation/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

part 'package:event_mate/presentation/authentication/login/widgets/login_page_input_fields.dart';

class LoginPage extends StatelessWidget {
  const LoginPage();
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          LoginPageHeader(),
          SizedBox(height: 24),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  LoginPageEmailInput(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: LoginPagePasswordInput(),
                  ),
                  LoginPageForgotPasswordButton(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: LoginPageSignInButton(),
                  ),
                  LoginPageRedirectRegistrationButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
