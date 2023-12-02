import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/application/birthday_edit_bloc/birthday_edit_bloc.dart';
import 'package:event_mate/application/email_registration_bloc/email_registration_bloc.dart';
import 'package:event_mate/presentation/core/widgets/form_body.dart';
import 'package:event_mate/presentation/core/widgets/input_error_text.dart';
import 'package:event_mate/presentation/core/widgets/splashing_button.dart';
import 'package:event_mate/presentation/extension/build_context_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationBirthdayFormBody extends StatelessWidget {
  const RegistrationBirthdayFormBody();

  @override
  Widget build(BuildContext context) {
    final DateTime dateNow = DateTime.now();
    return BlocListener<BirthdayEditBloc, BirthdayEditState>(
      listenWhen: (previous, current) {
        return previous.validating == true &&
            current.validating == false &&
            current.isFormValid;
      },
      listener: (context, state) {
        final bloc = context.read<EmailRegistrationBloc>();
        final registrationData = bloc.state.registrationData;
        bloc.addNextStep(
          registrationData: registrationData.copyWith(
            dateOfBirth: state.birthdayDateOrNull,
          ),
        );
      },
      child: BlocBuilder<BirthdayEditBloc, BirthdayEditState>(
        builder: (context, state) {
          return FormBody(
            title: 'registration.birthday_form_title'.tr(),
            subtitle: 'registration.birthday_form_subtitle'.tr(),
            formField: Column(
              children: [
                SplashingButton(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: state.birthdayDateOrNull ?? dateNow,
                      firstDate: dateNow.subtract(
                        const Duration(days: 365 * 100),
                      ),
                      lastDate: dateNow,
                      initialDatePickerMode: DatePickerMode.year,
                      errorFormatText:
                          'registration.birthday_error_invalid_text'.tr(),
                      errorInvalidText:
                          'registration.birthday_error_invalid_text'.tr(),
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            colorScheme: ColorScheme.light(
                              surface: context.colors.surfacePrimary,
                              onSurface: context.colors.textPrimary,
                              onSurfaceVariant: context.colors.textPrimary,
                              primary: context.colors.primary,
                              onPrimary: context.colors.whiteBase,
                              onSecondary: context.colors.secondary,
                              onBackground: context.colors.borderPrimary,
                              error: context.colors.error,
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor: context.colors.tertiary,
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    ).then(
                      (value) {
                        if (value != null) {
                          context
                              .read<BirthdayEditBloc>()
                              .addBirthdayUpdated(date: value);
                        }
                      },
                    );
                  },
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: context.colors.surfacePrimary,
                    border: Border.all(
                      color: context.colors.borderPrimary,
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: context.colors.textSecondary,
                        ),
                        Text(
                          state.birthdayOption.isNone()
                              ? 'registration.birthday_hint_text'.tr()
                              : state.birthdayOrEmpty,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: context.colors.textSecondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
                if (state.errorText != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: InputErrorText(text: state.errorText!.tr()),
                  ),
              ],
            ),
            onRegistrationContinue: () {
              context.read<BirthdayEditBloc>().addBirthdayValidate();
            },
          );
        },
      ),
    );
  }
}
