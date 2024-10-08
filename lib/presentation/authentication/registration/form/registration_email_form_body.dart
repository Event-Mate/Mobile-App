import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/application/email_edit_bloc/email_edit_bloc.dart';
import 'package:event_mate/application/email_registration_bloc/email_registration_bloc.dart';
import 'package:event_mate/presentation/core/widgets/custom_text_form_field.dart';
import 'package:event_mate/presentation/core/widgets/form_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationEmailFormBody extends StatelessWidget {
  const RegistrationEmailFormBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmailEditBloc, EmailEditState>(
      listenWhen: (previous, current) {
        return previous.validating &&
            !current.validating &&
            current.isFormValid;
      },
      listener: (context, state) {
        final bloc = context.read<EmailRegistrationBloc>();
        final registrationData = bloc.state.registrationData;
        bloc.addNextStep(
          registrationData: registrationData.copyWith(
            email: state.emailOrEmpty,
          ),
        );
      },
      builder: (context, state) {
        return FormBody(
          title: 'registration.email_form_title'.tr(),
          subtitle: 'registration.email_form_subtitle'.tr(),
          formField: CustomTextFormField(
            hintText: 'registration.email_hint_text'.tr(),
            errorText: state.errorText?.tr(),
            keyboardType: TextInputType.emailAddress,
            validating: state.validating,
            value: state.emailOrEmpty,
            onChanged: (value) {
              context.read<EmailEditBloc>().addEmailUpdated(email: value);
            },
          ),
          onRegistrationContinue: () {
            context.read<EmailEditBloc>().addEmailValidate();
          },
        );
      },
    );
  }
}
