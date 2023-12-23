import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:flutter/material.dart';

class LoginPageHeader extends StatelessWidget {
  const LoginPageHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.35,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          Positioned(
            top: -200,
            left: -20,
            right: -20,
            child: Container(
              width: 450,
              height: 450,
              decoration: BoxDecoration(
                color: context.colors.primary.withOpacity(.9),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 75,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'login.page_title'.tr(),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: context.colors.background,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'login.page_subtitle'.tr(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: context.colors.background,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
