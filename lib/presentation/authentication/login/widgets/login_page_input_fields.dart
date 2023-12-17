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
      child: const CustomTextFormField(
        // TODO(Furkan): translate
        hintText: 'Email',
        keyboardType: TextInputType.emailAddress,
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
      child: CustomTextFormField(
        // TODO(Furkan): translate
        hintText: 'Password',
        obscureText: true,
        trailing: BouncingButton(
          child: Icon(
            // TODO(Furkan): implement via bloc
            Icons.visibility_off,
            color: context.colors.textSecondary,
          ),
          onTap: () {
            // TODO(Furkan): on tap
            // context
            //     .read<PasswordEditBloc>()
            //     .addPasswordVisibilityToggled();
          },
        ),
      ),
    );
  }
}
