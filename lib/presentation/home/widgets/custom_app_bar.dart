import 'package:event_mate/application/bottom_navbar_bloc/bottom_navbar_bloc.dart';
import 'package:event_mate/environment.dart' as env;
import 'package:event_mate/presentation/chat/chat_page.dart';
import 'package:event_mate/presentation/core/constants/app_text_styles.dart';
import 'package:event_mate/presentation/core/extension/build_context_easy_navigation_ext.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavbarBloc, BottomNavbarState>(
      builder: (context, state) {
        if (state is BottomNavbarProfilePageState) {
          return const SizedBox(height: kToolbarHeight);
        } else {
          return const _DefaultAppBar();
        }
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DefaultAppBar extends StatelessWidget {
  const _DefaultAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colors.primary,
      elevation: 0,
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.flare_rounded,
            color: context.colors.background,
            size: 26,
          ),
          const SizedBox(width: 2),
          Text(
            env.APP_TITLE,
            style: tsHeadLineMedium.copyWith(color: context.colors.background),
          ),
        ],
      ),
      actions: const [
        _OpenChatButton(),
        SizedBox(width: 12),
      ],
    );
  }
}

class _OpenChatButton extends StatelessWidget {
  const _OpenChatButton();

  @override
  Widget build(BuildContext context) {
    return BouncingButton(
      onTap: () {
        context.openPage(const ChatPage());
      },
      child: Icon(
        Icons.chat,
        color: context.colors.background,
        size: 26,
      ),
    );
  }
}

class _ProfileAppBar extends StatelessWidget {
  const _ProfileAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colors.primary,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Profil',
        style: tsHeadLineMedium.copyWith(color: context.colors.background),
      ),
    );
  }
}
