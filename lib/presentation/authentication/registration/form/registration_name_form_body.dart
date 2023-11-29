import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/application/email_registration_bloc/email_registration_bloc.dart';
import 'package:event_mate/application/name_edit_bloc/name_edit_bloc.dart';
import 'package:event_mate/presentation/core/widgets/custom_text_form_field.dart';
import 'package:event_mate/presentation/core/widgets/form_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationNameFormBody extends StatelessWidget {
  const RegistrationNameFormBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NameEditBloc, NameEditState>(
      listenWhen: (previous, current) {
        return previous.validating == true &&
            current.validating == false &&
            current.isFormValid;
      },
      listener: (context, state) {
        final bloc = context.read<EmailRegistrationBloc>();
        final userData = bloc.state.userData;
        bloc.addNextStep(
          userData: userData.copyWith(displayName: state.nameOrEmpty),
        );
      },
      builder: (context, state) {
        return FormBody(
          title: 'registration.name_form_title'.tr(),
          subtitle: 'registration.name_form_subtitle'.tr(),
          formField: CustomTextFormField(
            hintText: 'registration.name_hint_text'.tr(),
            errorText: state.errorText?.tr(),
            keyboardType: TextInputType.name,
            value: state.nameOrEmpty,
            onChanged: (value) {
              context.read<NameEditBloc>().addNameUpdated(name: value);
            },
          ),
          onContinue: () {
            context.read<NameEditBloc>().addNameValidate();
          },
        );
      },
    );
  }
}
