import 'package:event_mate/application/my_profile_bloc/my_profile_bloc.dart';
import 'package:event_mate/presentation/core/constants/app_icons.dart';
import 'package:event_mate/presentation/core/extension/build_context_easy_navigation_ext.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_button.dart';
import 'package:event_mate/presentation/profile/my_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colors.primary,
      elevation: 0,
      centerTitle: true,
      title: const Icon(
        AppIcons.appIcon,
        size: 34,
      ),
      actions: const [
        _CircularProfilePhotoButton(),
        SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
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
                  child: CircularProgressIndicator(
                    color: context.colors.primary,
                  ),
                );
              }

              final avatarUrl = state.avatarUrl;

              if (avatarUrl == null) return const SizedBox();

              return Image.network(
                avatarUrl,
                width: 36,
                height: 36,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      ),
    );
  }
}
