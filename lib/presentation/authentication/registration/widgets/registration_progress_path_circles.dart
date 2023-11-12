import 'package:event_mate/application/email_registration_bloc/email_registration_bloc.dart';
import 'package:event_mate/presentation/authentication/registration/registration_page.dart';
import 'package:event_mate/presentation/extension/build_context_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripple_animation/ripple_animation.dart';

class RegistrationProgressPathCircles extends StatelessWidget {
  const RegistrationProgressPathCircles();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailRegistrationBloc, EmailRegistrationState>(
      buildWhen: (previous, current) =>
          previous.currentStepIndex != current.currentStepIndex,
      builder: (context, state) {
        final currentStepIndex = state.currentStepIndex;

        return Row(
          children: [
            for (int i = 0; i < RegistrationSteps.stepsMap.length; i++) ...[
              if (i == currentStepIndex) ...{
                RepaintBoundary(
                  child: RippleAnimation(
                    color: context.colors.secondary,
                    minRadius: 10,
                    ripplesCount: 8,
                    delay: const Duration(milliseconds: 300),
                    duration: const Duration(milliseconds: 1800),
                    repeat: true,
                    child: const _ProgressPathCircle(currentStep: true),
                  ),
                )
              } else
                _ProgressPathCircle(stepCompleted: i < currentStepIndex),
              if (i != RegistrationSteps.stepsMap.length - 1)
                Container(
                  width: 20,
                  height: 4,
                  color: i < currentStepIndex
                      ? context.colors.secondary
                      : context.colors.textSecondary,
                )
            ],
          ],
        );
      },
    );
  }
}

class _ProgressPathCircle extends StatelessWidget {
  const _ProgressPathCircle({
    this.stepCompleted = false,
    this.currentStep = false,
  });
  final bool stepCompleted;
  final bool currentStep;
  @override
  Widget build(BuildContext context) {
    final placheholderSize = currentStep ? 9.0 : 12.0;
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: stepCompleted
            ? context.colors.secondary
            : context.colors.background,
        border: Border.all(
          width: currentStep ? 5 : 2,
          color: stepCompleted || currentStep
              ? context.colors.secondary
              : context.colors.textSecondary,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: stepCompleted
          ? Icon(Icons.check, color: context.colors.background, size: 14)
          : SizedBox.square(dimension: placheholderSize),
    );
  }
}
