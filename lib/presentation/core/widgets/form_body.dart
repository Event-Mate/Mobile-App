import 'package:event_mate/presentation/authentication/registration/widgets/registration_complete_button.dart';
import 'package:event_mate/presentation/authentication/registration/widgets/registration_continue_button.dart';
import 'package:event_mate/presentation/extension/build_context_theme_ext.dart';
import 'package:flutter/material.dart';

class FormBody extends StatelessWidget {
  const FormBody({
    required this.title,
    required this.subtitle,
    required this.formField,
    this.skipStepButton,
    this.updateProfileButton,
    this.onRegistrationContinue,
    this.onRegistrationSubmit,
  }) : assert(
          onRegistrationContinue != null || onRegistrationSubmit != null,
          'onContinue and onSubmit cannot be null at the same time',
        );

  final String title;
  final String subtitle;
  final Widget formField;
  final Widget? skipStepButton;
  final Widget? updateProfileButton;
  final VoidCallback? onRegistrationContinue;
  final VoidCallback? onRegistrationSubmit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: context.colors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: context.colors.textSecondary),
                  ),
                ],
              ),
            ),
            formField,
          ],
        ),
        if (updateProfileButton != null) ...{
          Align(alignment: Alignment.bottomCenter, child: updateProfileButton)
        } else ...{
          if (onRegistrationSubmit != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RegistrationCompleteButton(onTap: onRegistrationSubmit!),
                  if (skipStepButton != null) ...[
                    skipStepButton!,
                  ],
                ],
              ),
            )
          else
            Align(
              alignment: Alignment.bottomRight,
              child: RegistrationContinueButton(onTap: onRegistrationContinue!),
            ),
        }
      ],
    );
  }
}
