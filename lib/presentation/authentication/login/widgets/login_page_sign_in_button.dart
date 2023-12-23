import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/application/email_edit_bloc/email_edit_bloc.dart';
import 'package:event_mate/application/email_login_bloc/email_login_bloc.dart';
import 'package:event_mate/application/password_edit_bloc/password_edit_bloc.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/widgets/custom_progress_indicator.dart';
import 'package:event_mate/presentation/core/widgets/splashing_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPageSignInButton extends StatelessWidget {
  const LoginPageSignInButton();
  @override
  Widget build(BuildContext context) {
    return SplashingButton(
      onTap: () {
        final email = context.read<EmailEditBloc>().state.emailOrEmpty;
        final password = context.read<PasswordEditBloc>().state.passwordOrEmpty;
        context
            .read<EmailLoginBloc>()
            .add(EmailLoginFormSentEvent(email: email, password: password));
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
      child: BlocBuilder<EmailLoginBloc, EmailLoginState>(
        buildWhen: (previous, current) =>
            previous.submitting != current.submitting,
        builder: (context, state) {
          if (state.submitting)
            return CustomProgressIndicator(color: context.colors.background);

          return Text(
            'login.sign_in_button_text'.tr(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: context.colors.background,
            ),
            textAlign: TextAlign.center,
          );
        },
      ),
    );
  }
}
