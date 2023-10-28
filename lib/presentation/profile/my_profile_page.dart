import 'package:event_mate/application/my_profile_bloc/my_profile_bloc.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_back_button.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_button.dart';
import 'package:event_mate/presentation/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/extension/build_context_toast_msg_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            if (state.userInformationOption.isNone())
              return const Center(child: CircularProgressIndicator());

            assert(!state.processFailed);
            final userInfo = state.userInformationOrNull!;

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
                        Text('displayName: ${userInfo.displayName}'),
                        Text('email: ${userInfo.email}'),
                        Text('username: ${userInfo.username}'),
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
                          'logout',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: context.colors.textPrimary),
                        ),
                      ),
                      onTap: () {
                        print('logged out!');
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
