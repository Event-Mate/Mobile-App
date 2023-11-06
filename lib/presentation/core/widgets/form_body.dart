import 'package:event_mate/presentation/authentication/registration/widgets/registration_continue_button.dart';
import 'package:event_mate/presentation/extension/build_context_theme_ext.dart';
import 'package:flutter/material.dart';

class FormBody extends StatelessWidget {
  const FormBody({
    required this.title,
    required this.subtitle,
    required this.formField,
    required this.onSubmit,
    this.submitButton,
  });

  final String title;
  final String subtitle;
  final Widget formField;
  final VoidCallback onSubmit;
  final Widget? submitButton;

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
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: context.colors.textPrimary),
                  ),
                ],
              ),
            ),
            formField,
          ],
        ),
        if (submitButton != null)
          Align(
            alignment: Alignment.bottomCenter,
            child: submitButton,
          )
        else
          Align(
            alignment: Alignment.bottomRight,
            child: RegistrationContinueButton(
              onTap: onSubmit,
            ),
          ),
      ],
    );
  }
}
