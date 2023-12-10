import 'package:event_mate/application/my_profile_bloc/my_profile_bloc.dart';
import 'package:event_mate/injection.dart';
import 'package:event_mate/presentation/core/constants/app_icons.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_button.dart';
import 'package:event_mate/presentation/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/extension/easy_navigation_ext.dart';
import 'package:event_mate/presentation/profile/my_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage();

// TODO(Furkan): Burası tasarlanacak.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MyProfileBloc>()..addFetch(),
      child: Scaffold(
        backgroundColor: context.colors.background,
        appBar: AppBar(
          backgroundColor: context.colors.background,
          elevation: 0,
          title: const Icon(
            AppIcons.appIcon,
            size: 34,
          ),
          actions: const [
            _CircularProfilePhotoButton(),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('123123'),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircularProfilePhotoButton extends StatelessWidget {
  const _CircularProfilePhotoButton();

  @override
  Widget build(BuildContext context) {
    return BouncingButton(
      onTap: () {
        context.openPage(
          BlocProvider.value(
            value: context.read<MyProfileBloc>(),
            child: const MyProfilePage(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: context.colors.borderPrimary),
          borderRadius: BorderRadius.circular(100),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: BlocBuilder<MyProfileBloc, MyProfileState>(
            buildWhen: (previous, current) =>
                previous.userDataOption.isNone() &&
                current.userDataOption.isSome(),
            builder: (context, state) {
              if (state.userDataOption.isNone()) {
                return Center(
                  child:
                      CircularProgressIndicator(color: context.colors.primary),
                );
              }
              // TODO(Furkan): UserData bir extension yardımıyla edinilebilecek kadar kücük bir parça haline gelsin. Sonrasında tüm state.userDataOption lar düzenlenecek.
              final avatarUrl = state.userDataOption.fold(
                () => null,
                (userDataOrFailure) => userDataOrFailure.fold(
                  (failure) => null,
                  (userData) => userData.avatarUrl,
                ),
              );

              if (avatarUrl == null) return const SizedBox();

              return Image.network(
                avatarUrl,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      ),
    );
  }
}
