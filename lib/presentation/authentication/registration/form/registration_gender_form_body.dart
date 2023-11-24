import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/application/email_registration_bloc/email_registration_bloc.dart';
import 'package:event_mate/application/gender_edit_bloc/gender_edit_bloc.dart';
import 'package:event_mate/core/enums/gender_type.dart';
import 'package:event_mate/presentation/core/widgets/form_body.dart';
import 'package:event_mate/presentation/core/widgets/input_error_text.dart';
import 'package:event_mate/presentation/extension/build_context_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationGenderFormBody extends StatelessWidget {
  const RegistrationGenderFormBody();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenderEditBloc, GenderEditState>(
      listenWhen: (previous, current) =>
          previous.validating && !current.validating && current.isFormValid,
      listener: (context, state) {
        context.read<EmailRegistrationBloc>().addNextStep();
      },
      builder: (context, state) {
        return FormBody(
          title: 'registration.gender_form_title'.tr(),
          subtitle: 'registration.gender_form_subtitle'.tr(),
          formField: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final gender in GenderType.values) ...[
                _GenderRadioTile(genderType: gender)
              ],
              const SizedBox(height: 12),
              if (state.errorText != null)
                InputErrorText(text: state.errorText!),
            ],
          ),
          onSubmit: () {
            context.read<GenderEditBloc>().addGenderValidated();
          },
        );
      },
    );
  }
}

class _GenderRadioTile extends StatelessWidget {
  const _GenderRadioTile({required this.genderType});
  final GenderType genderType;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenderEditBloc, GenderEditState>(
      buildWhen: (previous, current) =>
          previous.genderOption != current.genderOption,
      builder: (context, state) {
        final selectedGender = state.genderOrNull;
        return RadioListTile<GenderType>(
          value: genderType,
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
          ),
          title: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: context.colors.textPrimary),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          contentPadding: EdgeInsets.zero,
          fillColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.selected))
              return context.colors.primary;
            else
              return context.colors.textPrimary;
          }),
          groupValue: selectedGender,
          onChanged: (value) {
            if (value != null) {
              context.read<GenderEditBloc>().addGenderUpdated(gender: value);
            }
          },
        );
      },
    );
  }

  String get title {
    switch (genderType) {
      case GenderType.MAN:
        return "registration.gender_man".tr();
      case GenderType.WOMAN:
        return "registration.gender_woman".tr();
      case GenderType.NON_BINARY:
        return "registration.gender_non_binary".tr();
      default:
        return "";
    }
  }
}
