import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/application/email_registration_bloc/email_registration_bloc.dart';
import 'package:event_mate/presentation/authentication/registration/enum/registration_step_type.dart';
import 'package:event_mate/presentation/authentication/registration/widgets/registration_continue_button.dart';
import 'package:event_mate/presentation/authentication/registration/widgets/registration_progress_circle.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_back_button.dart';
import 'package:event_mate/presentation/extension/build_context_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

part 'widgets/registration_steps.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: context.read<EmailRegistrationBloc>().state.currentStepIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmailRegistrationBloc, EmailRegistrationState>(
      listenWhen: (previous, current) =>
          previous.currentStepIndex != current.currentStepIndex,
      listener: (context, state) {
        pageController.animateToPage(
          state.currentStepIndex,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      },
      child: BlocBuilder<EmailRegistrationBloc, EmailRegistrationState>(
        builder: (context, state) {
          final currentStepIndex = state.currentStepIndex;
          return Scaffold(
            backgroundColor: context.colors.background,
            appBar: AppBar(
              backgroundColor: context.colors.background,
              elevation: 0,
              leading: BouncingBackButton(
                onTap: () {
                  if (currentStepIndex <= 0) {
                    Navigator.of(context).pop();
                  } else {
                    context.read<EmailRegistrationBloc>().addPreviousStep();
                  }
                },
              ),
              centerTitle: true,
              title: Row(
                children: [
                  for (int i = 0; i < RegistrationSteps.steps.length; i++) ...[
                    if (i == currentStepIndex) ...{
                      RippleAnimation(
                        color: context.colors.success,
                        minRadius: 8,
                        ripplesCount: 10,
                        delay: const Duration(milliseconds: 300),
                        duration: const Duration(milliseconds: 1800),
                        repeat: true,
                        child: const RegistrationProgressCircle(
                          currentStep: true,
                        ),
                      )
                    } else
                      RegistrationProgressCircle(
                        stepCompleted: _stepCompleted(
                          index: i,
                          currentStepIndex: currentStepIndex,
                        ),
                      ),
                    if (i != RegistrationSteps.steps.length - 1)
                      Container(
                        width: 20,
                        height: 4,
                        color: _stepCompleted(
                          index: i,
                          currentStepIndex: currentStepIndex,
                        )
                            ? context.colors.success
                            : context.colors.textSecondary,
                      )
                  ],
                ],
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: PageView(
                  key: const PageStorageKey('registration_page_view'),
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: RegistrationSteps.steps.values.toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  bool _stepCompleted({
    required int index,
    required int currentStepIndex,
  }) {
    if (index < currentStepIndex) {
      return true;
    } else
      return false;
  }
}
