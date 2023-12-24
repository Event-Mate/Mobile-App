part of 'package:event_mate/presentation/authentication/login/login_page.dart';

class LoginPageEmailInput extends StatelessWidget {
  const LoginPageEmailInput();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: context.colors.accent.withOpacity(.2),
            blurRadius: 10,
          ),
        ],
      ),
      child: BlocBuilder<EmailEditBloc, EmailEditState>(
        buildWhen: (previous, current) =>
            previous.emailOrEmpty != current.emailOrEmpty,
        builder: (context, state) {
          return CustomTextFormField(
            hintText: 'login.email_hint_text'.tr(),
            keyboardType: TextInputType.emailAddress,
            value: state.emailOrEmpty,
            onChanged: (value) {
              context.read<EmailEditBloc>().addEmailUpdated(email: value);
            },
          );
        },
      ),
    );
  }
}

class LoginPagePasswordInput extends StatelessWidget {
  const LoginPagePasswordInput();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: context.colors.accent.withOpacity(.2),
            blurRadius: 10,
          ),
        ],
      ),
      child: BlocBuilder<PasswordEditBloc, PasswordEditState>(
        buildWhen: (previous, current) =>
            previous.passwordOrEmpty != current.passwordOrEmpty ||
            previous.hidePassword != current.hidePassword,
        builder: (context, state) {
          return CustomTextFormField(
            hintText: 'login.password_hint_text'.tr(),
            value: state.passwordOrEmpty,
            keyboardType: TextInputType.visiblePassword,
            obscureText: state.hidePassword,
            trailing: BouncingButton(
              child: Icon(
                state.hidePassword ? Icons.visibility : Icons.visibility_off,
                color: context.colors.textSecondary,
              ),
              onTap: () {
                context.read<PasswordEditBloc>().addPasswordVisibilityToggled();
              },
            ),
            onChanged: (value) {
              context
                  .read<PasswordEditBloc>()
                  .addPasswordUpdated(password: value);
            },
          );
        },
      ),
    );
  }
}
