import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/application/email_registration_bloc/email_registration_bloc.dart';
import 'package:event_mate/application/gender_edit_bloc/gender_edit_bloc.dart';
import 'package:event_mate/core/enums/gender_type.dart';
import 'package:event_mate/presentation/core/constants/app_text_styles.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/widgets/form_body.dart';
import 'package:event_mate/presentation/core/widgets/input_error_text.dart';
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
        final bloc = context.read<EmailRegistrationBloc>();
        final registrationData = bloc.state.registrationData;
        bloc.addNextStep(
          registrationData: registrationData.copyWith(
            genderType: state.genderOrNull,
          ),
        );
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
              if (state.errorText != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InputErrorText(text: state.errorText!.tr()),
                ),
            ],
          ),
          onRegistrationContinue: () {
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
            style: tsBodyMedium.copyWith(color: context.colors.textPrimary),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          contentPadding: EdgeInsets.zero,
          fillColor: MaterialStateColor.resolveWith(
            (states) {
              if (states.contains(MaterialState.selected))
                return context.colors.primary;
              else
                return context.colors.textPrimary;
            },
          ),
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
      case GenderType.OTHER:
        return "registration.gender_other".tr();
      case GenderType.NONE:
        return "registration.gender_none".tr();
      default:
        return "";
    }
  }
}
