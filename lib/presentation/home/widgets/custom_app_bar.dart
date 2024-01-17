import 'package:event_mate/environment.dart' as env;
import 'package:event_mate/presentation/chat/chat_page.dart';
import 'package:event_mate/presentation/core/constants/app_text_styles.dart';
import 'package:event_mate/presentation/core/extension/build_context_easy_navigation_ext.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_button.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colors.primary,
      elevation: 0,
      centerTitle: true,
      title: Text(
        env.APP_TITLE,
        style: tsHeadLineMedium.copyWith(color: context.colors.background),
      ),
      actions: const [
        _OpenChatButton(),
        SizedBox(width: 12),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
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
