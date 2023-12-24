import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/presentation/authentication/login/login_page.dart';
import 'package:event_mate/presentation/authentication/registration/registration_page.dart';
import 'package:event_mate/presentation/core/constants/app_assets.dart';
import 'package:event_mate/presentation/core/constants/app_text_styles.dart';
import 'package:event_mate/presentation/core/extension/build_context_easy_navigation_ext.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/widgets/splashing_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(
                assetSvgAuthPageImage,
                height: MediaQuery.sizeOf(context).height * 0.5,
              ),
              SvgPicture.asset(assetSvgEventMateIcon, width: 100, height: 100),
              const _AuthButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthButtons extends StatelessWidget {
  const _AuthButtons();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SplashingButton(
          onTap: () => context.openPage(const LoginPage()),
          decoration: BoxDecoration(
            color: context.colors.accent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: context.colors.accent),
          ),
          width: width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'auth.login_button_text'.tr(),
              style: tsBodyMedium.copyWith(
                color: context.colors.background,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SplashingButton(
          onTap: () => context.openPage(const RegistrationPage()),
          width: width,
          decoration: BoxDecoration(
            color: context.colors.background,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: context.colors.accent),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'auth.register_button_text'.tr(),
              style: tsBodyMedium.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
