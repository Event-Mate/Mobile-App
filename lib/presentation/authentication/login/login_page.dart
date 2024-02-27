import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/application/authentication_bloc/authentication_bloc.dart';
import 'package:event_mate/application/email_edit_bloc/email_edit_bloc.dart';
import 'package:event_mate/application/email_login_bloc/email_login_bloc.dart';
import 'package:event_mate/application/password_edit_bloc/password_edit_bloc.dart';
import 'package:event_mate/core/enums/main_routes.dart';
import 'package:event_mate/injection.dart';
import 'package:event_mate/presentation/authentication/login/widgets/login_page_form.dart';
import 'package:event_mate/presentation/authentication/login/widgets/login_page_header.dart';
import 'package:event_mate/presentation/core/extension/build_context_easy_navigation_ext.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/extension/build_context_toast_msg_ext.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_button.dart';
import 'package:event_mate/presentation/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'package:event_mate/presentation/authentication/login/widgets/login_page_input_fields.dart';

class LoginPage extends StatelessWidget {
  const LoginPage();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<EmailEditBloc>()),
        BlocProvider(create: (_) => getIt<PasswordEditBloc>()),
        BlocProvider(create: (_) => getIt<EmailLoginBloc>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<EmailLoginBloc, EmailLoginState>(
            listenWhen: (previous, current) =>
                previous.failureOrUserDataWToken !=
                current.failureOrUserDataWToken,
            listener: (context, state) {
              state.failureOrUserDataWToken.fold(
                () {},
                (failureOrUnit) {
                  failureOrUnit.fold(
                    (failure) {
                      context.showErrorToast('login.failed_toast_message'.tr());
                    },
                    (_) {
                      context.read<AuthenticationBloc>().addCheckLoginStatus();
                    },
                  );
                },
              );
            },
          ),
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listenWhen: (previous, current) =>
                previous is AuthLoggedOutState && current is AuthLoggedInState,
            listener: (context, state) {
              context.showSuccessToast(
                'login.success_toast_message'.tr(),
              );
              context.openNamedPageWithClearStack(AppRoutes.MAIN.value);
            },
          ),
        ],
        child: const Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              LoginPageHeader(),
              LoginPageForm(),
            ],
          ),
        ),
      ),
    );
  }
}
