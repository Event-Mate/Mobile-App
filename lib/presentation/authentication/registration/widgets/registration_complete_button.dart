import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/application/email_registration_bloc/email_registration_bloc.dart';
import 'package:event_mate/presentation/core/constants/app_text_styles.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_button.dart';
import 'package:event_mate/presentation/core/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationCompleteButton extends StatelessWidget {
  const RegistrationCompleteButton({required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailRegistrationBloc, EmailRegistrationState>(
      buildWhen: (previous, current) =>
          previous.completing != current.completing,
      builder: (context, state) {
        final completing = state.completing;
        return BouncingButton(
          onTap: completing ? () {} : onTap,
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: context.colors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: completing
                ? CustomProgressIndicator(
                    size: 21,
                    color: context.colors.background,
                  )
                : Text(
                    'registration.form_button_complete_title'.tr(),
                    textAlign: TextAlign.center,
                    style: tsBodyMedium.copyWith(
                      color: context.colors.background,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
