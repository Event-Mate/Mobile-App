import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/application/email_registration_bloc/email_registration_bloc.dart';
import 'package:event_mate/application/password_edit_bloc/password_edit_bloc.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_button.dart';
import 'package:event_mate/presentation/core/widgets/custom_text_form_field.dart';
import 'package:event_mate/presentation/core/widgets/form_body.dart';
import 'package:event_mate/presentation/extension/build_context_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationPasswordFormBody extends StatelessWidget {
  const RegistrationPasswordFormBody();
  @override
  Widget build(BuildContext context) {
    return BlocListener<PasswordEditBloc, PasswordEditState>(
      listenWhen: (previous, current) {
        return previous.validating &&
            !current.validating &&
            current.isFormValid;
      },
      listener: (context, state) {
        final bloc = context.read<EmailRegistrationBloc>();
        final userData = bloc.state.userData;
        bloc.addNextStep(
          userData: userData.copyWith(password: state.passwordOrEmpty),
        );
      },
      child: BlocBuilder<PasswordEditBloc, PasswordEditState>(
        builder: (context, state) {
          return FormBody(
            title: 'registration.password_form_title'.tr(),
            subtitle: 'registration.password_form_subtitle'.tr(),
            formField: CustomTextFormField(
              hintText: 'registration.password_hint_text'.tr(),
              errorText: state.errorText?.tr(),
              value: state.passwordOrEmpty,
              keyboardType: TextInputType.visiblePassword,
              trailing: BouncingButton(
                child: Icon(
                  state.hidePassword ? Icons.visibility : Icons.visibility_off,
                  color: context.colors.textSecondary,
                ),
                onTap: () {
                  context
                      .read<PasswordEditBloc>()
                      .addPasswordVisibilityToggled();
                },
              ),
              obscureText: state.hidePassword,
              onChanged: (value) {
                context
                    .read<PasswordEditBloc>()
                    .addPasswordUpdated(password: value);
              },
            ),
            onContinue: () {
              context.read<PasswordEditBloc>().addPasswordValidate();
            },
          );
        },
      ),
    );
  }
}
