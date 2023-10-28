import 'package:event_mate/presentation/extension/build_context_theme_ext.dart';
import 'package:flutter/material.dart';

class RegistrationProgressCircle extends StatelessWidget {
  const RegistrationProgressCircle({
    this.stepCompleted = false,
    this.currentStep = false,
  });
  final bool stepCompleted;
  final bool currentStep;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        color:
            stepCompleted ? context.colors.success : context.colors.background,
        border: Border.all(
          width: currentStep ? 5 : 2,
          color: stepCompleted || currentStep
              ? context.colors.success
              : context.colors.textSecondary,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: stepCompleted
          ? Icon(
              Icons.check,
              color: context.colors.background,
              size: 13,
            )
          : null,
    );
  }
}
