import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/application/authentication_bloc/authentication_bloc.dart';
import 'package:event_mate/application/color_theme_bloc/color_theme_bloc.dart';
import 'package:event_mate/application/my_profile_bloc/my_profile_bloc.dart';
import 'package:event_mate/application/splash_bloc/splash_bloc.dart';
import 'package:event_mate/core/enums/main_routes.dart';
import 'package:event_mate/environment_variables.env' as env;
import 'package:event_mate/injection.dart';
import 'package:event_mate/presentation/authentication/authentication_page.dart';
import 'package:event_mate/presentation/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/extension/easy_navigation_ext.dart';
import 'package:event_mate/presentation/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'package:event_mate/presentation/splash/splash_page.dart';
part 'package:event_mate/presentation/splash/root_page.dart';
part 'package:event_mate/presentation/splash/loading_page.dart';

class EventMateApp extends StatelessWidget {
  const EventMateApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<MyProfileBloc>()),
        BlocProvider(create: (_) => getIt<SplashBloc>()..addCheckAppState()),
        BlocProvider(
          create: (_) => getIt<AuthenticationBloc>()..addCheckLoginStatus(),
        ),
        BlocProvider(create: (_) => getIt<ColorThemeBloc>()..addInitialized())
      ],
      child: MaterialApp(
        title: env.APP_TITLE,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.SPLASH.value,
        routes: {
          AppRoutes.SPLASH.value: (context) => const SplashPage(),
          AppRoutes.ROOT.value: (context) => const RootPage(),
          AppRoutes.AUTH.value: (context) => const AuthenticationPage(),
          AppRoutes.HOME.value: (context) => const HomePage(),
        },
      ),
    );
  }
}
