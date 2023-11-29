import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/application/email_registration_bloc/email_registration_bloc.dart';
import 'package:event_mate/application/username_edit_bloc/username_edit_bloc.dart';
import 'package:event_mate/presentation/core/widgets/custom_text_form_field.dart';
import 'package:event_mate/presentation/core/widgets/form_body.dart';
import 'package:event_mate/presentation/extension/build_context_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationUsernameFormBody extends StatelessWidget {
  const RegistrationUsernameFormBody();
  @override
  Widget build(BuildContext context) {
    return BlocListener<UsernameEditBloc, UsernameEditState>(
      listenWhen: (previous, current) {
        return previous.validating == true &&
            current.validating == false &&
            current.isFormValid;
      },
      listener: (context, state) {
        final bloc = context.read<EmailRegistrationBloc>();
        final userData = bloc.state.userData;
        bloc.addNextStep(
          userData: userData.copyWith(username: state.usernameOrEmpty),
        );
      },
      child: BlocBuilder<UsernameEditBloc, UsernameEditState>(
        builder: (context, state) {
          return FormBody(
            title: 'registration.username_form_title'.tr(),
            subtitle: 'registration.username_form_subtitle'.tr(),
            formField: CustomTextFormField(
              hintText: 'registration.username_hint_text'.tr(),
              errorText: state.errorText?.tr(),
              value: state.usernameOrEmpty,
              onChanged: (value) {
                context
                    .read<UsernameEditBloc>()
                    .addUsernameUpdated(username: value);
              },
              leading: Text(
                '@',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: context.colors.textSecondary),
              ),
            ),
            onContinue: () {
              context.read<UsernameEditBloc>().addUsernameValidate();
            },
          );
        },
      ),
    );
  }
}
