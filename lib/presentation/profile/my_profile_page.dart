import 'package:event_mate/application/my_profile_bloc/my_profile_bloc.dart';
import 'package:event_mate/injection.dart';
import 'package:event_mate/presentation/core/constants/app_text_styles.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/extension/build_context_toast_msg_ext.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_back_button.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MyProfileBloc>()..addFetch(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: context.colors.background,
          elevation: 0,
          leading: BouncingBackButton(color: context.colors.primary),
        ),
        backgroundColor: context.colors.background,
        body: BlocListener<MyProfileBloc, MyProfileState>(
          listener: (context, state) {
            if (state.processFailed) {
              context.showErrorToast('Failed to fetch user information!');
              Navigator.of(context).pop();
            }
          },
          child: BlocBuilder<MyProfileBloc, MyProfileState>(
            builder: (context, state) {
              if (state.userDataOption.isNone())
                return const Center(child: CircularProgressIndicator());

              assert(!state.processFailed);
              final userData = state.userDataOrNull!;

              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 24.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text('displayName: ${userData.displayName}'),
                          Text('email: ${userData.email}'),
                          Text('username: ${userData.username}'),
                        ],
                      ),
                      BouncingButton(
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 24,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            color: context.colors.primary,
                            border: Border.all(
                              color: context.colors.borderPrimary,
                            ),
                          ),
                          child: Text(
                            // #translate: logout
                            'logout',
                            textAlign: TextAlign.center,
                            style: tsBodyMedium.copyWith(
                              color: context.colors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onTap: () {
                          if (kDebugMode) {
                            print('logged out!');
                          }
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
