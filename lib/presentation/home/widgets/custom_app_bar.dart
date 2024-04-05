import 'package:easy_localization/easy_localization.dart';
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
        if (state is BottomNavbarEventsPageState) {
          return const _SuggestedEventsAppBar();
        } else {
          return const _DefaultAppBar();
        }
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SuggestedEventsAppBar extends StatelessWidget {
  const _SuggestedEventsAppBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight * 4,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: const [0.0, 0.7, 0.9, 1.0],
          colors: [
            context.colors.primary,
            context.colors.primary.withOpacity(0.5),
            context.colors.primary.withOpacity(0.25),
            context.colors.primary.withOpacity(0.0),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '🎭 ${'home_page.suggested_events_section_title'.tr()}',
            style: tsHeadLineSmall.copyWith(
              color: context.colors.background,
              shadows: [
                Shadow(
                  color: context.colors.accent,
                  offset: const Offset(4, 4),
                  blurRadius: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
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
            size: 20,
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
