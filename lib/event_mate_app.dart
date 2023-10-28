import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/application/color_theme_bloc/color_theme_bloc.dart';
import 'package:event_mate/application/email_registration_bloc/email_registration_bloc.dart';
import 'package:event_mate/application/my_profile_bloc/my_profile_bloc.dart';
import 'package:event_mate/core/enums/main_routes.dart';
import 'package:event_mate/environment_variables.env';
import 'package:event_mate/injection.dart';
import 'package:event_mate/presentation/authentication/authentication_page.dart';
import 'package:event_mate/presentation/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventMateApp extends StatelessWidget {
  const EventMateApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<MyProfileBloc>()),
        BlocProvider(create: (_) => getIt<EmailRegistrationBloc>()),
        BlocProvider(create: (_) => getIt<ColorThemeBloc>()..addInitialized())
      ],
      child: BlocBuilder<EmailRegistrationBloc, EmailRegistrationState>(
        buildWhen: (previous, current) {
          return previous.processFailureOrUnitOption !=
              current.processFailureOrUnitOption;
        },
        builder: (context, state) {
          final initialRoute = state.processFailureOrUnitOption.fold(
            () => MainRoutes.AUTH.value,
            (_) => MainRoutes.HOME.value,
          );
          return MaterialApp(
            title: APP_TITLE,
            theme: ThemeData(
              primaryColor: context.colors.primary,
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light,
                  statusBarBrightness: Brightness.light,
                ),
              ),
            ),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            initialRoute: initialRoute,
            routes: {
              MainRoutes.AUTH.value: (context) => const AuthenticationPage(),
              MainRoutes.HOME.value: (context) => const HomePage(),
            },
          );
        },
      ),
    );
  }
}
