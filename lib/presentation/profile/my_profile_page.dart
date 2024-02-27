import 'package:event_mate/application/authentication_bloc/authentication_bloc.dart';
import 'package:event_mate/application/my_profile_bloc/my_profile_bloc.dart';
import 'package:event_mate/injection.dart';
import 'package:event_mate/presentation/core/constants/app_text_styles.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/extension/build_context_toast_msg_ext.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MyProfileBloc>()..addFetch(),
      child: Scaffold(
        backgroundColor: context.colors.background,
        body: BlocConsumer<MyProfileBloc, MyProfileState>(
          listener: (context, state) {
            if (state.processFailed) {
              context.showErrorToast(
                // #translate: my_profile_page.loading_user_profile_error_text
                'Error occured while loading user profile',
              );
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            if (state.userDataOption.isNone())
              return const Center(child: CircularProgressIndicator());

            assert(!state.processFailed);
            final userData = state.userDataOrNull!;

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text('displayName: ${userData.displayName}'),
                        Text('email: ${userData.email}'),
                        Text('username: ${userData.username}'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    BouncingButton(
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(50),
                          ),
                          color: context.colors.redBase,
                          border: Border.all(
                            color: context.colors.borderPrimary,
                          ),
                        ),
                        child: Text(
                          // #translate: log_out
                          'Log out',
                          textAlign: TextAlign.center,
                          style: tsBodyMedium.copyWith(
                            color: context.colors.background,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        context.read<AuthenticationBloc>().addLogout();
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
