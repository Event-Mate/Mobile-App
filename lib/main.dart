import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/core/enums/locale_type.dart';
import 'package:event_mate/event_mate_app.dart';
import 'package:event_mate/injection.dart';
import 'package:event_mate/restartable_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final overlayStyle = SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.black,
    statusBarBrightness: Brightness.dark,
  );
  SystemChrome.setSystemUIOverlayStyle(overlayStyle);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final injected = await setupInjection();
  if (injected) {
    runApp(
      EasyLocalization(
        supportedLocales: [
          Locale(LocaleType.EN.value),
          Locale(LocaleType.TR.value),
        ],
        path: 'assets/languages',
        fallbackLocale: Locale(LocaleType.EN.value),
        child: const RestartableApp(child: EventMateApp()),
      ),
    );
  } else {
    throw Exception('Injection failed ❌');
  }
}
