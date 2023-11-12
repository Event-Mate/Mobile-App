import 'package:event_mate/application/email_edit_bloc/email_edit_bloc.dart';
import 'package:event_mate/application/email_registration_bloc/email_registration_bloc.dart';
import 'package:event_mate/application/gender_edit_bloc/gender_edit_bloc.dart';
import 'package:event_mate/application/name_edit_bloc/name_edit_bloc.dart';
import 'package:event_mate/application/password_edit_bloc/password_edit_bloc.dart';
import 'package:event_mate/application/username_edit_bloc/username_edit_bloc.dart';
import 'package:event_mate/injection.dart';
import 'package:event_mate/presentation/authentication/registration/enum/registration_step_type.dart';
import 'package:event_mate/presentation/authentication/registration/form/registration_email_form_body.dart';
import 'package:event_mate/presentation/authentication/registration/form/registration_gender_form_body.dart';
import 'package:event_mate/presentation/authentication/registration/form/registration_name_form_body.dart';
import 'package:event_mate/presentation/authentication/registration/form/registration_password_form_body.dart';
import 'package:event_mate/presentation/authentication/registration/form/registration_username_form_body.dart';
import 'package:event_mate/presentation/authentication/registration/widgets/registration_progress_path_circles.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_back_button.dart';
import 'package:event_mate/presentation/extension/build_context_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<EmailRegistrationBloc>()),
        BlocProvider(create: (context) => getIt<NameEditBloc>()),
        BlocProvider(create: (context) => getIt<UsernameEditBloc>()),
        BlocProvider(create: (context) => getIt<EmailEditBloc>()),
        BlocProvider(create: (context) => getIt<PasswordEditBloc>()),
        BlocProvider(create: (context) => getIt<GenderEditBloc>()),
      ],
      child: BlocListener<EmailRegistrationBloc, EmailRegistrationState>(
        listenWhen: (previous, current) =>
            previous.currentStepIndex != current.currentStepIndex,
        listener: (context, state) {
          pageController.animateToPage(
            state.currentStepIndex,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
          FocusScope.of(context).unfocus();
        },
        child: BlocBuilder<EmailRegistrationBloc, EmailRegistrationState>(
          builder: (context, state) {
            final currentStepIndex = state.currentStepIndex;
            return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                backgroundColor: context.colors.background,
                appBar: AppBar(
                  backgroundColor: context.colors.background,
                  elevation: 0,
                  leading: BouncingBackButton(
                    color: context.colors.textPrimary,
                    onTap: () {
                      if (currentStepIndex <= 0) {
                        Navigator.of(context).pop();
                      } else {
                        context.read<EmailRegistrationBloc>().addPreviousStep();
                      }
                    },
                  ),
                  centerTitle: true,
                  title: const RegistrationProgressPathCircles(),
                ),
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: pageController,
                      children: RegistrationSteps.stepsMap.values.toList(),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class RegistrationSteps {
  const RegistrationSteps._();
  // TODO(Furkan): Add date,avatar steps
  static Map<RegistrationStepType, Widget> stepsMap = {
    RegistrationStepType.NAME: const RegistrationNameFormBody(),
    RegistrationStepType.USERNAME: const RegistrationUsernameFormBody(),
    RegistrationStepType.EMAIL: const RegistrationEmailFormBody(),
    RegistrationStepType.PASSWORD: const RegistrationPasswordFormBody(),
    RegistrationStepType.GENDER: const RegistrationGenderFormBody(),
    RegistrationStepType.DATE_OF_BIRTH: Container(color: Colors.purple),
    RegistrationStepType.AVATAR_URL: Container(color: Colors.orange),
  };
}
